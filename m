Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1084549646F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350228AbiAURs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382045AbiAURsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:48:07 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3897C06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:48:06 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id s11so11605370ioe.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=BvgJ1KhQ09zgjMCeIf9WRh/NdcZGH1G7T7wldmYjdSE=;
        b=cNENdJj9VCARwTzDZtisAhMuzRAldSqAvbGoQbnJu32rHz0Q1fS52L8cwBPwk6voZU
         dMUT7Gpa3TD8uvgwbpI5R5rHhp0CQspe1jE4mdX9yocZtgmKiKpdZC5U9/9EkgW3HOc/
         w+ACPfBlyX+zmaNQnqLEedOWd+iA6Dpgdlqcncu4Pk6EM7VKuZTaS2OKWdnaC/Aqvdih
         cGZZc/y2zEQr1hC9BX5DfDPBk9ULLQWsDB70O5+iM1iUvdf0S+eX/Cy1Tv0pkoL976dX
         W77cuSpyDlMW2gpriOkOEVtNUqoc0fly/P3AcRB0QS2FqZk/VHVOwu8++g1u/WVC/N6u
         CqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=BvgJ1KhQ09zgjMCeIf9WRh/NdcZGH1G7T7wldmYjdSE=;
        b=aSljji6GZJS15WTXPTBOvcR2BS678Pd/oZl015GHWmardZLASjadWnh/a1KvVuG82o
         6dxZNzaGjqolvmAHL5j9blV/tkUM67jRtNbodmn5llw6uBQLwznLsTtTkPCE4F7irTI7
         gAjhQfQoBj6xoOqtD0C5Dmfqg20UHW+EuCPb2SSnpo6/aJ+g1AIowl+jTbHioSwTxpd7
         9ApKZ9jkEKxr3jmi0ZZVTOCEttwNNG6HyPjAPW8iHEqCxKJrdzsrQw5ARbIzqDr42NEV
         FNthQUbae6tFoyXtRIxzBMZop+P51jLPMbsrM0g3cE4OEAw4FTHy5n1aezWBV4Y4T3Cg
         0mQg==
X-Gm-Message-State: AOAM531dMCQe0pUz4KUjR8Nz1Kc6uc4XwC7x2H7jcTldr+jr5bvst1xT
        JNVgY/RYcU6FBvJvwtc5KRz/MFphGKB4RQ==
X-Google-Smtp-Source: ABdhPJwb1HnQ9ro85HHm7p9EGFys4Nphpx6yExOfHsGC6ziznix/qKRunIQxVlDaDPiFTugQ23IK7w==
X-Received: by 2002:a05:6638:a3c:: with SMTP id 28mr2396405jao.281.1642787285706;
        Fri, 21 Jan 2022 09:48:05 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h12sm1549324iok.25.2022.01.21.09.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 09:48:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        Miaoqian Lin <linmq006@gmail.com>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
In-Reply-To: <20220120101025.22411-1-linmq006@gmail.com>
References: <20220120101025.22411-1-linmq006@gmail.com>
Subject: Re: [PATCH] block: fix memory leak in disk_register_independent_access_ranges
Message-Id: <164278728249.232198.7158002983506256334.b4-ty@kernel.dk>
Date:   Fri, 21 Jan 2022 10:48:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 10:10:25 +0000, Miaoqian Lin wrote:
> kobject_init_and_add() takes reference even when it fails.
> According to the doc of kobject_init_and_add()
> 
>    If this function returns an error, kobject_put() must be called to
>    properly clean up the memory associated with the object.
> 
> Fix this issue by adding kobject_put().
> Callback function blk_ia_ranges_sysfs_release() in kobject_put()
> can handle the pointer "iars" properly.
> 
> [...]

Applied, thanks!

[1/1] block: fix memory leak in disk_register_independent_access_ranges
      commit: c321e650a45c4228cce1107680ac74e06f014906

Best regards,
-- 
Jens Axboe


