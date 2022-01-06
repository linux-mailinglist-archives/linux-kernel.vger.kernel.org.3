Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367A648676F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241075AbiAFQLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241031AbiAFQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:11:38 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16692C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 08:11:38 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j11so6001639lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 08:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UweD5BJ4DKQCz9vlPdatipHmRP/OHAThtxD90vvKQYs=;
        b=VMBXuw310pEBE0hRKuhM5FjpdbHWyARebd7bXxHSCQMKbEEfGfHJivVMia0R9uQPCb
         2d9aj90JU8m59mfIHl3+hL5Vn4DpsKYdRAtgTLJxYF8ivzTWHLsPxgFqyJ6CXDLEULzd
         WI5MbRyzIL3jRwV+eplpbRPn4ARPWfHhhh7W7HEXpwDqn2Xn+jgK6aGlP/GUf2r6CsPa
         zfm0Z18ub2H0ooIFrU/XE/Uz/DOmz+k/e4JgQRIW16TJgOx2ezoJjZr2HWUe7Vo3g22G
         87gsDiMSTjrcNetqjQxCoc3XnpWiKblgIN0fIXYP8Ybu8syo2A07wxohzqa4LLeBCfq+
         W7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UweD5BJ4DKQCz9vlPdatipHmRP/OHAThtxD90vvKQYs=;
        b=jJHhJAyh89gXkSUzy2FrT+i30ZV6Q2ZAYp3qGpODEtQQFN/HXaQING8mNwtsm3+6Jo
         /w/+yoml5KFC/wrJofl/CkQ/l52/NdPu1rprIlS347JarE4zUFdHrZv+1Vox2ZNQ3n6O
         gfbGZJZiDBOiVMQQU6f3fMnucnUys74ufdcRS4twLocZhZWI56PdtzxYWVYSIZRo6otu
         ogG9bCPbJHp9Ha2lJf8TiHxz6As32gJEX6QG1PLpuu+Lsl3C3p+KG+Wbfphf5khzVRLI
         kP80w/pjKWW4mShD9N1HgqdbgNabezquMKTb50Jf5RpVbiMeHe0XFypFri3OwGYPfEqW
         uxbA==
X-Gm-Message-State: AOAM530IRovCx4gMhyebtS+R3Hj6bTMdvI2B91T8BXXa8J3WLwlC+Wgl
        rzGs2ml1RZ2OGjQeN8c77ts=
X-Google-Smtp-Source: ABdhPJxncGOMXL666kdVArKsvJheKvIRNs4K0S0x16vtIctFIiKdHrJu38Q1dxdsqTcS9HrJe3PQwA==
X-Received: by 2002:ac2:46d1:: with SMTP id p17mr54816098lfo.578.1641485496348;
        Thu, 06 Jan 2022 08:11:36 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id u26sm213623lfi.62.2022.01.06.08.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 08:11:34 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 3A60A5A0020; Thu,  6 Jan 2022 19:11:34 +0300 (MSK)
Date:   Thu, 6 Jan 2022 19:11:34 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Pintu Kumar <quic_pintu@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, ebiederm@xmission.com,
        christian.brauner@ubuntu.com, sfr@canb.auug.org.au,
        legion@kernel.org, sashal@kernel.org, chris.hyser@oracle.com,
        ccross@google.com, pcc@google.com, dave@stgolabs.net,
        caoxiaofeng@yulong.com, david@redhat.com, pintu.ping@gmail.com
Subject: Re: [PATCH] sysinfo: include availram field in sysinfo struct
Message-ID: <YdcUttZWaqYQpR1K@grain>
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 09:04:10PM +0530, Pintu Kumar wrote:
> The sysinfo member does not have any "available ram" field and
> the bufferram field is not much helpful either, to get a rough
> estimate of available ram needed for allocation.
> 
> One needs to parse MemAvailable field separately from /proc/meminfo
> to get this info instead of directly getting if from sysinfo itself.
> 
> Thus, this patch introduce a new field as availram in sysinfo
> so that all the info total/free/available can be retrieved from
> one place itself.
> 
> There are couple of places in kernel as well where this can be improved.
> For example:
> In fs/proc/meminfo.c:
> meminfo_proc_show:
>    si_meminfo(&i);
>    available = si_mem_available();
> Now with this change the second call be avoided.
> Thus, we can directly do:
> show_val_kb(m, "MemAvailable:   ", i.availram);
> 
> Note, this also requires update in procfs for free and other commands.
> Like in free command as well we frist call sysinfo then again parse
> /proc/meminfo to get available field.
> This can be avoided too with higher kernel version.
> 
> A sample output with single sysinfo call is shown below:
> Total RAM: 248376 kB
>  Free RAM: 231540 kB
> Avail RAM: 230448 kB
> 
> Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>
> ---
>  include/uapi/linux/sysinfo.h | 1 +
>  kernel/sys.c                 | 4 ++++
>  mm/page_alloc.c              | 2 ++
>  3 files changed, 7 insertions(+)
> 
> diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
> index 435d5c2..6e77e90 100644
> --- a/include/uapi/linux/sysinfo.h
> +++ b/include/uapi/linux/sysinfo.h
> @@ -12,6 +12,7 @@ struct sysinfo {
>  	__kernel_ulong_t freeram;	/* Available memory size */
>  	__kernel_ulong_t sharedram;	/* Amount of shared memory */
>  	__kernel_ulong_t bufferram;	/* Memory used by buffers */
> +	__kernel_ulong_t availram;	/* Memory available for allocation */
>  	__kernel_ulong_t totalswap;	/* Total swap space size */
>  	__kernel_ulong_t freeswap;	/* swap space still available */
>  	__u16 procs;		   	/* Number of current processes */

Hi! Sorry, but I don't understand -- the sysinfo structure seems to
be part of user API, no? Don't we break it up here?
