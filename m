Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E99349C078
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiAZBNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiAZBNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:13:42 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B3DC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:13:41 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l25so22919266wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CFXUuMD/RxDnEPUeEcbsOCRjB4mk9SQ3BfvXI60YXYs=;
        b=BMechtmzreeAKWlgV+2TdjoMHWA/SJUeWzj6Rwdrvd5HBqn4J2cXG2ijPQzEqrSPMC
         8q9STiYuONo50Hx9rw1SUJPPcNhgBqVzpo1tRmXXR3j49rFcppwIWIjOvM+9a7qFyFga
         H08hKNhweyvi7YsQbx9/glN8aokZj+l9rMFCAHjlCsc71vuq7JdaIocGL8uFrWnR/kD1
         aKT7qkzjRdeZcmU4Z4x59vT4or3IJfTzMo2XvOAcOXT56SVtvUDsu1k4jdFd7nB3ZyKY
         aWAv9yoJuOCUv/3Xw61f1yHUVQYQ8AmzZShcqGLhduZCgKFzyKDIY7SPGeatB2oO+5Bq
         IMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CFXUuMD/RxDnEPUeEcbsOCRjB4mk9SQ3BfvXI60YXYs=;
        b=61NoZliX8DoEiOzn4Gis1wLxvRi7zKLjvXmyXLs/4O3i9PkfEqwGT3Y5lyX5SwP9d8
         s8zLoLQaL7vylGNbaUAyRhb489Qyury3DUBYqtMD+YA7wZV1rO1XXTjIzhyJiR2Ti6Xu
         l3pUOY//EReCCRPRYb8bxhrVVTq9ttGSVdtIfynySCoD7eL0G0Un8C3lELIGSRTg5XG0
         BJnuNaJqxVs0lOFI0+zvFXlEvDZWx//GBfxjSgsFCHur5Zrcy8oqoRIMYVX/VQnOekQ1
         +Eda0XjPN6oQapKoXzwSTTFsxe3cZ1CbVHibZrFyYr3gyDRmBfVu7OZnCQ05Z0NcL17y
         Z/IQ==
X-Gm-Message-State: AOAM531zgbTyAMqVW2bbsz97s+khKfJ6nsdhg6j87cZz95npLJmwLo+Z
        rCKE19YsP+b/DQh2ZoSiel3Z9NsKsVhk+A==
X-Google-Smtp-Source: ABdhPJyvbJf/H8CgNv5jLlxc03o51t7SEhNgUGSvL2xHce673xbPpfdtlUui7Wwc9numaqG7/kkiHg==
X-Received: by 2002:a5d:4d09:: with SMTP id z9mr20077026wrt.638.1643159620475;
        Tue, 25 Jan 2022 17:13:40 -0800 (PST)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id 11sm1815610wmx.5.2022.01.25.17.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 17:13:39 -0800 (PST)
Date:   Wed, 26 Jan 2022 01:13:37 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] staging: r8188eu: remove DBG_88E calls from
 os_dep/ioctl_linux.c
Message-ID: <YfCgQbFxfVZXw9Fg@equinox>
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-7-phil@philpotter.co.uk>
 <a681a562-eb41-9dc8-703a-5b235c15a3a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a681a562-eb41-9dc8-703a-5b235c15a3a1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:03:06PM +0300, Pavel Skripkin wrote:
> Hi Phillip,
> 
> On 1/25/22 01:44, Phillip Potter wrote:
> > Remove all DBG_88E calls from os_dep/ioctl_linux.c, as they do not
> > conform to kernel coding standards and are superfluous. Also restructure
> > where appropriate to remove no longer needed code left behind by removal
> > of these calls. This will allow the eventual removal of the DBG_88E macro
> > itself.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> 
> [code snip]
> 
> > @@ -3746,7 +3541,6 @@ static int rtw_dbg_port(struct net_device *dev,
> >   			u32 write_num = extra_arg;
> >   			int i;
> > -			u16 final;
> >   			struct xmit_frame	*xmit_frame;
> >   			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
> > @@ -3760,11 +3554,7 @@ static int rtw_dbg_port(struct net_device *dev,
> >   			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0) != _SUCCESS)
> >   				ret = -EPERM;
> > -			final = rtw_read16(padapter, reg);
> > -			if (start_value + write_num - 1 == final)
> > -				DBG_88E("continuous IOL_CMD_WW_REG to 0x%x %u times Success, start:%u, final:%u\n", reg, write_num, start_value, final);
> > -			else
> > -				DBG_88E("continuous IOL_CMD_WW_REG to 0x%x %u times Fail, start:%u, final:%u\n", reg, write_num, start_value, final);
> > +			rtw_read16(padapter, reg);
> >   		}
> >   			break;
> 
> I see, that you somewhere removes reads and somewhere leaves them. What's
> the difference? I saw, that one of the places has the comment, that asks not
> to remove the read, but others do not have such comment
> 
> I can point to few places in 2 and 4 patches where you have removed reads.
> 
> 
> 
> [code snip]
> 
> > @@ -4014,16 +3664,8 @@ static int rtw_dbg_port(struct net_device *dev,
> >   			{
> >   				u32 odm_flag;
> > -				if (0xf == extra_arg) {
> > +				if (extra_arg == 0xf) {
> >   					GetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
> > -					DBG_88E(" === DMFlag(0x%08x) ===\n", odm_flag);
> > -					DBG_88E("extra_arg = 0  - disable all dynamic func\n");
> > -					DBG_88E("extra_arg = 1  - disable DIG- BIT(0)\n");
> > -					DBG_88E("extra_arg = 2  - disable High power - BIT(1)\n");
> > -					DBG_88E("extra_arg = 3  - disable tx power tracking - BIT(2)\n");
> > -					DBG_88E("extra_arg = 4  - disable BT coexistence - BIT(3)\n");
> > -					DBG_88E("extra_arg = 5  - disable antenna diversity - BIT(4)\n");
> > -					DBG_88E("extra_arg = 6  - enable all dynamic func\n");
> >   				} else {
> >   					/*	extra_arg = 0  - disable all dynamic func
> >   						extra_arg = 1  - disable DIG
> > @@ -4032,51 +3674,17 @@ static int rtw_dbg_port(struct net_device *dev,
> >   					*/
> >   					SetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &extra_arg);
> >   					GetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
> > -					DBG_88E(" === DMFlag(0x%08x) ===\n", odm_flag);
> >   				}
> >   			}
> >   			break;
> 
> Is odm_flag needed now? Seems like it was used only for printing random
> debug info

You're right, it can probably go :-)

> 
> >   		case 0xfd:
> >   			rtw_write8(padapter, 0xc50, arg);
> > -			DBG_88E("wr(0xc50) = 0x%x\n", rtw_read8(padapter, 0xc50));
> >   			rtw_write8(padapter, 0xc58, arg);
> > -			DBG_88E("wr(0xc58) = 0x%x\n", rtw_read8(padapter, 0xc58));
> > -			break;
> > -		case 0xfe:
> > -			DBG_88E("rd(0xc50) = 0x%x\n", rtw_read8(padapter, 0xc50));
> > -			DBG_88E("rd(0xc58) = 0x%x\n", rtw_read8(padapter, 0xc58));
> > -			break;
> > -		case 0xff:
> > -			DBG_88E("dbg(0x210) = 0x%x\n", rtw_read32(padapter, 0x210));
> > -			DBG_88E("dbg(0x608) = 0x%x\n", rtw_read32(padapter, 0x608));
> > -			DBG_88E("dbg(0x280) = 0x%x\n", rtw_read32(padapter, 0x280));
> > -			DBG_88E("dbg(0x284) = 0x%x\n", rtw_read32(padapter, 0x284));
> > -			DBG_88E("dbg(0x288) = 0x%x\n", rtw_read32(padapter, 0x288));
> > -
> > -			DBG_88E("dbg(0x664) = 0x%x\n", rtw_read32(padapter, 0x664));
> > -
> > -			DBG_88E("\n");
> > -
> > -			DBG_88E("dbg(0x430) = 0x%x\n", rtw_read32(padapter, 0x430));
> > -			DBG_88E("dbg(0x438) = 0x%x\n", rtw_read32(padapter, 0x438));
> > -
> > -			DBG_88E("dbg(0x440) = 0x%x\n", rtw_read32(padapter, 0x440));
> > -
> > -			DBG_88E("dbg(0x458) = 0x%x\n", rtw_read32(padapter, 0x458));
> > -
> > -			DBG_88E("dbg(0x484) = 0x%x\n", rtw_read32(padapter, 0x484));
> > -			DBG_88E("dbg(0x488) = 0x%x\n", rtw_read32(padapter, 0x488));
> > -
> > -			DBG_88E("dbg(0x444) = 0x%x\n", rtw_read32(padapter, 0x444));
> > -			DBG_88E("dbg(0x448) = 0x%x\n", rtw_read32(padapter, 0x448));
> > -			DBG_88E("dbg(0x44c) = 0x%x\n", rtw_read32(padapter, 0x44c));
> > -			DBG_88E("dbg(0x450) = 0x%x\n", rtw_read32(padapter, 0x450));
> >   			break;
> >   		}
> 
> And here you also removes the reads. I guess, some kind of magic pattern is
> used
> 

So these calls are macro arguments, they would never be executed under
normal circumstances anyway, unless the rtw_debug kernel module was
passed in as 5 or more - it is 1 by default. The DBG_88E macro would
expand during preprocessing phase to (for example):

do {
	if (5 <= GlobalDebugLevel)
		pr_info("R8188EU: " "dbg(0x450) = 0x%x\n", rtw_read32(padapter, 0x450));
} while (0)

As this is never executed under normal circumstances anyway, I would say
calls like these are therefore safe to remove. Happy to be convinced
though :-) Many thanks.

Regards,
Phil
