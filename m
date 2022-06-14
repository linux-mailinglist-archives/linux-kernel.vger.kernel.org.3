Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3583154B44A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbiFNPNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiFNPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:13:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8CC377FC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78A6460C87
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB42C3411B;
        Tue, 14 Jun 2022 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655219628;
        bh=aAruh180MgBrPRKPWzJtrQlciVl99j09DArcIaC5JuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vo6xERnY0mIFVPT72fgBS0EyPCI49PtIoEaRADdJsq4OgOQVuN8dThhg3ROsgxVFb
         XZtjzBg0PVRrLN1iupv1tt6q7viTbXvOrEI2rFHkHRHM5+rF0wgjwxXzoCTO8OflXw
         n/JtVyF1WC59q3k76iQuuq1SjHtI+zagNFCTJMjw=
Date:   Tue, 14 Jun 2022 17:13:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhi Song <zhi.song@bytedance.com>
Cc:     vilhelm.gray@gmail.com, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isa: put_device after failing to device_register
Message-ID: <YqilqYHZmLbhi3o0@kroah.com>
References: <20220614145757.1734996-1-zhi.song@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614145757.1734996-1-zhi.song@bytedance.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:57:57PM +0800, Zhi Song wrote:
> device_register() is used to register a device with the system.
> 
> We cannot directly free dev after calling this function,
> even if it returns an error.
> 
> We should use put_device() to give up the reference
> initialized in this function instead.

Same comments on this one as my last review.

greg k-h
