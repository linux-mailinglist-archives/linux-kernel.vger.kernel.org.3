Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFB8468CE1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 19:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbhLES71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 13:59:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58042 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbhLES7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 13:59:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 651F66111D;
        Sun,  5 Dec 2021 18:55:54 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 9AB8BC00446;
        Sun,  5 Dec 2021 18:55:51 +0000 (UTC)
Date:   Sun, 5 Dec 2021 19:01:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, jonathan.cameron@huawei.com
Subject: RFC: Should we have a device_for_each_available_child_node()?
Message-ID: <20211205190101.26de4a57@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This came up in review of
https://lore.kernel.org/linux-iio/20210725172458.487343-1-jic23@kernel.org/
which is a series converting a dt only driver over to generic properties.
I'm sending a separate email to raise the profile of the question rather
higher than it was buried in a driver review.

The original code used for_each_available_child_of_node(np, child) 
and the patch converted it to device_for_each_child_node().

Andy raised the question of whether it should have been
device_for_each_available_child_node() but that doesn't exist currently.

Things get more interesting when you look at the implementation of
device_for_each_child_node() which uses device_get_next_child_node()
which in turn calls fwnode_get_next_child_node() which calls
the get_next_child_node() op and for of that is
of_fwnode_get_next_child_node() which uses of_get_next_available_child()
rather than of_get_next_child().

So I think under the hood device_for_each_child_node() on of_ is going to
end up checking the node is available anyway.

So this all seemed a little odd given there were obvious calls to use
if we wanted to separate the two cases for device tree and they weren't
the ones used.  However, if we conclude that there is a bug here and
the two cases should be handled separately then it will be really hard
to be sure no driver is relying on this behaviour.

So, ultimately the question is:  Should I add a
device_for_each_available_child_node()?  It will be something like:

struct fwnode_handle *device_get_next_child_node(struct device *dev,
						 struct fwnode_handle *child)
{
	const struct fwnode_handle *fwnode = dev_fwnode(dev);
	struct fwnode_handle *next;

	/* Try to find a child in primary fwnode */
	next = fwnode_get_next_available_child_node(fwnode, child);
	if (next)
		return next;

	/* When no more children in primary, continue with secondary */
	if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
		next = fwnode_get_next_available_child_node(fwnode->secondary, child);

	return next;
}

#define device_for_each_child_node(dev, child)				\
	for (child = device_get_next_available_child_node(dev, NULL); child;	\
	     child = device_get_next_avaialble_child_node(dev, child))

As far as I can tell it doesn't make any difference for my particular bit
of refactoring in the sense of I won't break anything that currently
works by using device_for_each_child_node() but it may cause issues with
other firmware by enumerating disabled child nodes.

Jonathan





