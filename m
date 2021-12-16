Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3483D477FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 23:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhLPWWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 17:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhLPWW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 17:22:29 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4155EC061574;
        Thu, 16 Dec 2021 14:22:29 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d38so906431lfv.0;
        Thu, 16 Dec 2021 14:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:cc:subject:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+HEWTxN0MDr0ZGvDvF7WwVJpOBhBbuSX1UZJkIu2GZk=;
        b=VAazcsq7AbbriTGSYUvqxmPY8IF42ILQ5xzOvxTfUtJLkeUclB2j2lsNmdWc8lcj5W
         vgEMq0X4KGbwUyG3nI1oj6WjJXIAx8c9/c/syX7/Q2KXeFeQIROmY4K6UvbbE0zO3glB
         TwzqRZ3RFf95JLuEMFnXxkd/Kj+U/E5btiHSEG05TKaYT2oifgTXsItSOPW1N8D60cQu
         1Mw90fwYazu0WaabIWEAncmncv2qhd0rZ49uyjC8hRD7NP2q/vk/d/ibGHWQfPUDWMKM
         sWWXfNRoCqn3ouRKkUT/Mp5uLYveMhQ7GhkGHmhqchgKdwCv9cpW8iWmxbtT6AnGj8I6
         otkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HEWTxN0MDr0ZGvDvF7WwVJpOBhBbuSX1UZJkIu2GZk=;
        b=329RQ7v7nMiIw3wI6zdhUQXjhIBCy5bh3v1/S0+SqqJ7fJMQNRjFAFYGMNW8UFtAdF
         x4kNJlWzZvh/KrptBAMmH9SnfKqc0fR5fzqPNO6hb23ek4DFTbduizXpjsvK0wbdQK11
         pSEZigAEsQzkOmluvkQAh2oSr7fZtgmjpB86CfdunbaESmJeemyPcQAmL/0FSqcHKyDG
         cJaoepxdyBlvZ3Q2laIUwQbdoj8ekFk4Q83oYQwUH3Pi02hP39PUfpQNWyXXr0deCERH
         SMq+tbzZnogokoNrRhLmChbBrb1Xkn72xTlML1zl4rWWtkoAppTSybvY5LwSAX/ZeI1e
         fNTQ==
X-Gm-Message-State: AOAM5336/VqK32r0sEHxucQP+cNuFO1ROq/h+e5AzWNHbTX2uFuiUV8L
        ZAchAbvE0T4q8IrdRcEOtyDEI8eLlUxH6w==
X-Google-Smtp-Source: ABdhPJy8dQJNPIazDdKfOzklHrBIo12MdaldzTWmrzxWAslICqqohGJxWtH9VJ4TfWIRmdKRG/lu7A==
X-Received: by 2002:ac2:4c0b:: with SMTP id t11mr231727lfq.520.1639693347464;
        Thu, 16 Dec 2021 14:22:27 -0800 (PST)
Received: from netbook-debian (55-2-94-178.pool.ukrtel.net. [178.94.2.55])
        by smtp.gmail.com with ESMTPSA id t23sm1074373lfg.63.2021.12.16.14.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 14:22:27 -0800 (PST)
Date:   Fri, 17 Dec 2021 00:22:23 +0200
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        platform-driver-x86@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] hwmon: (nct6775) Support lock by ACPI mutex
Message-ID: <20211217002223.63b1e0a7@netbook-debian>
In-Reply-To: <20211128184549.9161-1-pauk.denis@gmail.com>
References: <20211128184549.9161-1-pauk.denis@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could you please provide a some feedback about such idea?

I have bigger list of supported boards that requires ACPI mutex lock,
but I prefer to have some feedback before send next version of patch.

I have created separate patch[1] with only boards where WMI methods is
enough. And if work on patch takes some time/additional patch
versions(for sure it will), I prefer to have that patch merged and
rebase current patch over resulted list of boards. 

Thank you.  
1. https://patchwork.kernel.org/project/linux-hwmon/list/?series=594167

On Sun, 28 Nov 2021 20:45:45 +0200
Denis Pauk <pauk.denis@gmail.com> wrote:

> Lock by a ACPI mutex that is required for support ASUS MAXIMUS VII
> HERO motherboard. In other case, all methods are returned zero
> instead of real values. Code uses acpi mutex before any IO operations
> in case when such acpi mutex is known.
> 
> Patch series adds additional check for chip ID, and if method
> returned zero, all calls by acpi_wmi are disabled. 
> 
> @Andy Shevchenko: 
> >> Do you need string_helpers.h after this change?  
> It was not required in the original patch, as it was included as part
> of some other header and I have left includes without changes.
> 
> I have a little bit changed conditionals in "add MAXIMUS VII HERO",
> code can change access variable several times: 
> * By the default, access is set to direct, 
> * after code has checked that wmi methods can return something useful,
> * and as the last step code has checked that mutext is existed and
> set access back to direct.
> 
> But as for me, it should be less confusing.
> 
> What do you think?
> 
> ---
> 
> Changes in v2:
> - Fix commit message.
> - Remove default acpi_board_ANY and use NULL instead.
> - Use chip ID everywhere.
> - Use an anonymous union for mutexes.
> - Use temporary status varibale in acpi calls.
> ---
> 
> Denis Pauk (3):
>   hwmon: (nct6775) Use lock function pointers in nct6775_data
>   hwmon: (nct6775) Implement custom lock by ACPI mutex
>   hwmon: (nct6775) add MAXIMUS VII HERO
> 
>  drivers/hwmon/nct6775.c | 364
> +++++++++++++++++++++++++++++----------- 1 file changed, 263
> insertions(+), 101 deletions(-)
> 
> 
> base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf



Best regards,
             Denis.
