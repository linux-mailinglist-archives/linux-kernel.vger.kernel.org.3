Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06557501785
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350764AbiDNPk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245248AbiDNOhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:37:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E626D205F0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:29:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A994B829D4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CE6C385A1;
        Thu, 14 Apr 2022 14:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649946592;
        bh=UPsMWquHq3IrAfXIyMTIbpV2XKwEzf42P41WLBE8r9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdkEf94dsFHtV5L9H4k3egElvIpweK/+mY9jzCchnVfwPGaPO0XBenkIR4O8rpkzj
         X88TZVpeb+NoR78SxKTsikGVIBr6rwoSa27jNZSY9oYBnd5UNntUUcOC3T4yyebUvT
         J+XKXoUqEG76AoEnU2vAJ0AMVEtxX0WiPOT7JEo4=
Date:   Thu, 14 Apr 2022 16:29:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 0/1] add support for enum module parameters
Message-ID: <Ylgv3U4HEtpk3sis@kroah.com>
References: <20220414123033.654198-1-jani.nikula@intel.com>
 <YlgfXxjefuxiXjtC@kroah.com>
 <87a6cneoco.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6cneoco.fsf@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 05:22:47PM +0300, Jani Nikula wrote:
> On Thu, 14 Apr 2022, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > On Thu, Apr 14, 2022 at 03:30:32PM +0300, Jani Nikula wrote:
> >> Hey, I've sent this before, ages ago, but haven't really followed
> >> through with it. I still think it would be useful for many scenarios
> >> where a plain number is a clumsy interface for a module param.
> >> 
> >> Thoughts?
> >
> > We should not be adding new module parameters anyway (they operate on
> > code, not data/devices), so what would this be used for?
> 
> I think it's just easier to use names than random values, and this also
> gives you range check on the input.
> 
> I also keep telling people not to add new module parameters, but it's
> not like they're going away anytime soon.

Existing ones can not go away (or change), but we do not have to add new
ones.

> If there's a solution to being able to pass device specific debug
> parameters at probe time, I'm all ears. At least i915 has a bunch of
> things which can't really be changed after probe, when debugfs for the
> device is around. Module parameters aren't ideal, but debugfs doesn't
> work for this.

configfs?

