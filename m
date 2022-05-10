Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC369521261
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbiEJKmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbiEJKm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:42:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFA8267C2C
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:38:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so1472249pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=6xgLoNI7AnkdMdRdHZQagLXDT+gwi8Sv7gdjtmJ1fxI=;
        b=T6qTS7KHImoKYcUCIh2yTrk/nUW/TK4BnMIPOFRnS9ToQQVZJX9ZQlKbCYW31c0IO1
         sld+XwFSToNAnhrZX50PHWDSBciQxB1A1RxgrcgIGnv6JHAzjXReB/MXWFCFV1eqNL8R
         zBQ7FeiOEgXkvzCOiwCT0pSLOrweX9bIzu5VO4rO5gOMQVvJQXKNQ3nj+sxXeS2UYmnB
         Th/dZASZ6FfFx9+0esk1NwNw8WLNRmvGyDvRgR4GIQQpmPPg/dYU3gadMQHwJAjLI+Dx
         aXMMfwDArKIjZPekEHfETJ+t1AGFD6AQCbQx3K9QxF3fKNhbNDXdBr+9DlvJlXOLF214
         WLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=6xgLoNI7AnkdMdRdHZQagLXDT+gwi8Sv7gdjtmJ1fxI=;
        b=gNa1poFAFnPR7FbvlDYGMKcdBZIuThMIlzertqs59ZGzLugT/ueMeXfhu05G/zTDEI
         iZaSlIbBpCMRlchEqajPOXttl3HAarosEWlXrpFmunjeq4xmL+dfQpdrzZnD8QnwVS8W
         XOX5zCa51kguD7Zsd+ys19y4mzoBgkB55LXQLtrB+DSZd49yGKeL6SMJZIgwi7WUe3ks
         XQA+H9ZKrlc7EZXBt2a6WMO6M432Tg2eLELdP1iNkb1yc8P3FKgKYmQgRGffjzfOh9wJ
         fbFw6AjYBSVcF7IqxsS2MBWjH/QFnqBul+uxNDvqli1MgOgrF5DBK2GOlR4H0BqZbyvo
         fBng==
X-Gm-Message-State: AOAM531AmftiseKF1fqsdICv8WYX41ZPeNW3/XIiEOmb/A30w3VNyneI
        WnzZPQXVW51hSPWgyLN9XqY=
X-Google-Smtp-Source: ABdhPJy2sDqUG4iE+M+9nKV8e7Dm6QX1UaW6u+uuX44X6Avdb00Clu5Sf5FhxTQSr0RHx4FiuKvk6Q==
X-Received: by 2002:a17:90b:314e:b0:1dc:d143:a15d with SMTP id ip14-20020a17090b314e00b001dcd143a15dmr23660047pjb.111.1652179108887;
        Tue, 10 May 2022 03:38:28 -0700 (PDT)
Received: from localhost (193-116-127-232.tpgi.com.au. [193.116.127.232])
        by smtp.gmail.com with ESMTPSA id j192-20020a638bc9000000b003c14af505fcsm10107925pge.20.2022.05.10.03.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:38:28 -0700 (PDT)
Date:   Tue, 10 May 2022 20:38:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 20/29] init/main: Delay initialization of the lockup
 detector after smp_init()
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Tony Luck <tony.luck@intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
        <20220506000008.30892-21-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20220506000008.30892-21-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-Id: <1652178524.7j2o02lrl8.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Ricardo Neri's message of May 6, 2022 9:59 am:
> Certain implementations of the hardlockup detector require support for
> Inter-Processor Interrupt shorthands. On x86, support for these can only
> be determined after all the possible CPUs have booted once (in
> smp_init()). Other architectures may not need such check.
>=20
> lockup_detector_init() only performs the initializations of data
> structures of the lockup detector. Hence, there are no dependencies on
> smp_init().

I think this is the only real thing which affects other watchdog types?

Not sure if it's a big problem, the secondary CPUs coming up won't
have their watchdog active until quite late, and the primary could
implement its own timeout in __cpu_up for secondary coming up, and
IPI it to get traces if necessary which is probably more robust.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

>=20
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: x86@kernel.org
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v5:
>  * Introduced this patch
>=20
> Changes since v4:
>  * N/A
>=20
> Changes since v3:
>  * N/A
>=20
> Changes since v2:
>  * N/A
>=20
> Changes since v1:
>  * N/A
> ---
>  init/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/init/main.c b/init/main.c
> index 98182c3c2c4b..62c52c9e4c2b 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1600,9 +1600,11 @@ static noinline void __init kernel_init_freeable(v=
oid)
> =20
>  	rcu_init_tasks_generic();
>  	do_pre_smp_initcalls();
> -	lockup_detector_init();
> =20
>  	smp_init();
> +
> +	lockup_detector_init();
> +
>  	sched_init_smp();
> =20
>  	padata_init();
> --=20
> 2.17.1
>=20
>=20
