Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4504B14EA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245515AbiBJSGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:06:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiBJSGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:06:19 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5626100A;
        Thu, 10 Feb 2022 10:06:19 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b13so12472933edn.0;
        Thu, 10 Feb 2022 10:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qt6kW2zXep4ghqJEwXtPsYU3/efOgjh+SFIIr7TfgOs=;
        b=kjTyAPaEKkIYLDfFpG+9boGa0L9rj642wPvHiIGjwYnOGcPnWq1locVItNYC51yMIP
         91sS/ZVYt1WVqdB9/V8X/Iub+ipAs0b/7fiSIyhMIeVHdZh28egQAYn6vhQijEN0rYuR
         KweE3HcNqeOB8LB0uxnacaWSoJ3I8GEvejy/PXMcnwx7CYFLZc0VC5JfdQYhWYIPJk55
         kAeId6Lc9sKgWn6HkY3exIbAOwO9bwvnPfgCtmydkZoAlny0Qsa0O5o/I3w4lDbnCGNH
         roIOJWquFANHxenqGsrfowq6AgwpoWzNAmYPdTJckbon6kzlVeM+J6krAVHowZZdUHvI
         6q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qt6kW2zXep4ghqJEwXtPsYU3/efOgjh+SFIIr7TfgOs=;
        b=e5pfai1FiNERJ/d02XEL0Upgbw9CCWNKfek2Z7bXdqjEDcfGHCQNkz6Dv4+JyPBL6R
         yNYZ+/srYg1+uS8hnU4xap6LG3cfr0MVoygWN/R7K9d5TTDmpQ908U5dMzkmNjaddTPO
         x0jpLCWtqUUCRhtzzvY2VpF7hDKhN/CQJhfOC0cR4D4Mpq5v0lMn6hwjXCaFbxWwfUrL
         W0jAlueT+D3eozFpCUV1FzeZ3gsSgsTK1JO3t6D6heY5+ZfTvJkmgBUi65JAuewg9+y/
         FSnYu0N9VSvoYnJc3PK5SSCycAfm9lRahUdjPb3aeqc92Y0K68i5b2c1jX4LX8RaXmMB
         Htmg==
X-Gm-Message-State: AOAM533A5NeqYFe+YE1BEqXpyWpAV8kCDFccWPRcWtA0I5cEemeDSlst
        A6+7L4jjiDvTPerjwCcOSPp5z1hJPRkCRrCV7tM=
X-Google-Smtp-Source: ABdhPJzliEYCuIC84EtkqtUb0DMAMWIhMoYRGQMmSOMMFthHsASZi6/xYmbJVaHyT9N6l+tzGIWFtg==
X-Received: by 2002:a05:6402:35d5:: with SMTP id z21mr7981441edc.17.1644516378266;
        Thu, 10 Feb 2022 10:06:18 -0800 (PST)
Received: from m4.home ([2a0b:f4c1:2::241])
        by smtp.gmail.com with ESMTPSA id pj22sm5429292ejb.192.2022.02.10.10.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 10:06:17 -0800 (PST)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.home with local (Exim 4.94.2)
        (envelope-from <cavok@m4>)
        id 1nIDpf-000Tys-Lr; Thu, 10 Feb 2022 19:06:15 +0100
Date:   Thu, 10 Feb 2022 19:06:15 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boottime warning from todays linux-next
Message-ID: <YgVUF5cyWWjPDdvv@m4>
References: <20220210184340.7eba108a@canb.auug.org.au>
 <20220210193302.686fa61a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210193302.686fa61a@canb.auug.org.au>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 07:33:02PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 10 Feb 2022 18:43:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > My qemu boot of a powerpc pseries_le_defconfig kernel produced these
> > kernel messages:
> > 
> >   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc3 #2
> >   Call Trace:
> >   [c0000000073e3a80] [c0000000007bfd40] dump_stack_lvl+0x74/0xa8 (unreliable)
> >   [c0000000073e3ac0] [c00000000057e3dc] __register_sysctl_table+0x60c/0x9f0
> >   [c0000000073e3bd0] [c000000002041170] init_fs_stat_sysctls+0x48/0x60
> >   [c0000000073e3bf0] [c000000000012110] do_one_initcall+0x60/0x2d0
> >   [c0000000073e3cd0] [c0000000020049f0] kernel_init_freeable+0x334/0x3dc
> >   [c0000000073e3db0] [c000000000012710] kernel_init+0x30/0x1a0
> >   [c0000000073e3e10] [c00000000000cd64] ret_from_kernel_thread+0x5c/0x64
> > 
> > Presumably introduced by commit
> > 
> >   b42bc9a3c511 ("Fix regression due to "fs: move binfmt_misc sysctl to its own file"")
> 
> OK, I cannot reproduce this with just Linus' tree.  I will try to bisect.

I could not reproduce it on either my amd64 or arm64.

Dom

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
