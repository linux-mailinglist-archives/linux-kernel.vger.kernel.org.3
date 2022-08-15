Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078C5592A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbiHOHRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241751AbiHOHPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:15:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23731EAD8;
        Mon, 15 Aug 2022 00:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 803ACB80C83;
        Mon, 15 Aug 2022 07:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2E5C433D7;
        Mon, 15 Aug 2022 07:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660547696;
        bh=yldIV9rWMK6rILPxJL/LPEfok8eZer6ZSHcjVHuKNvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yl5jdm7MmkV2L/0v6sdR+FMXj+DrGbFoYdk4p4iH9FqqegW3zZY4rj0LUP5RU03mJ
         6d8D/UXVK02drhwThJjDrmZy+nggfqPISYCGjiu2JWsI35Z2GPpMsSisy/DeaqjLwo
         xygiuNG8vCQqSZPDn/UbB9F2fAAXw0+P3hQiCJbQ=
Date:   Mon, 15 Aug 2022 09:14:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>,
        Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>, it+linux-media@molgen.mpg.de
Subject: Re: Missing MIPI IPU6 camera driver for Intel Alder Lake laptops
Message-ID: <YvnybHVFmpUJs4qi@kroah.com>
References: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
 <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
 <YvUaEDMbZD70x+hD@kroah.com>
 <YvUbhx4HSxAAwIvv@pendragon.ideasonboard.com>
 <YvUghWZbXIUofg5A@kroah.com>
 <YvmqL6Wz7o77ukF5@google.com>
 <YvnpVmnROTsWWw0o@kroah.com>
 <YvnrJBI8599+E43T@google.com>
 <YvnvnL9pBAgWMgTk@kroah.com>
 <YvnwtN1SwQjilJ97@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvnwtN1SwQjilJ97@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 04:07:32PM +0900, Sergey Senozhatsky wrote:
> On (22/08/15 09:02), Greg KH wrote:
> [..]
> > > We haven't sent out KCAM for upstream review yet. It's open sourced,
> > > as of this moment [1], but we still need some time and wanted to convert
> > > one of the previous generations of IPU drivers (IPU3) to KCAM first to
> > > see if everything is working as we wanted it to.
> > 
> > That didn't answer my question on when you were planning to actually
> > submit this :)
> 
> Definitely not today. Someday, for sure :)
> 
> I don't want to promise any timelines. But we are certainly not
> talking "weeks", we are talking "months". Several months is a
> realistic timeline.

Ok, so getting this merged is a good year out at the best, realisticly 2
years given that once you submit the first version for review, the real
work will start happening.

So I'll stick with my original statement, don't buy this hardware as the
vendors don't seem to want to upstream the drivers any time soon :(

thanks,

greg k-h
