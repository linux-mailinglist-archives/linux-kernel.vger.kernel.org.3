Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD6B5A63C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiH3MoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiH3MoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:44:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBF2FB0EA;
        Tue, 30 Aug 2022 05:44:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A68EBB81B31;
        Tue, 30 Aug 2022 12:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED835C433D7;
        Tue, 30 Aug 2022 12:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661863458;
        bh=MZQXd4iBfxW6ysVrR9tBCuwjlhyECO+K8YtLNNSq1Lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IGahwIj84I+2asPqCN04jkMh7YuHrFE6KFmvJpgjuFNOJgB/bRA0EQvLZAlOQXxK8
         Pf+vq0B3KQXonc1GRuBQHKB6cezzIuGn8JmEpxa4zvCUBqsWl2X3JC4MwReOicjFy5
         W2PGSrGX5txNpphH/Hs1wBM5ApMpgL90upGbBxiA=
Date:   Tue, 30 Aug 2022 14:44:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ray Chi <raychi@google.com>
Cc:     mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        albertccwang@google.com, badhri@google.com, pumahsu@google.com
Subject: Re: [PATCH] usb: core: stop USB enumeration if too many retries
Message-ID: <Yw4GH4U5ULV3VFSY@kroah.com>
References: <20220826075839.292615-1-raychi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826075839.292615-1-raychi@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 03:58:39PM +0800, Ray Chi wrote:
> If a broken accessory connected to a USB host, usbcore might
> keep doing enumeration retries and it will take a long time to
> cause system unstable.
> 
> This patch provides a quirk to specific USB ports of the hub to
> stop USB enumeration if needed.

Where does it ever allow the port to handle new devices in the future if
the device is removed and then a new one is added back?  Or is the port
just now dead for forever?

thanks,

greg k-h
