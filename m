Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA1D5A5E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiH3Iay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiH3Iao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:30:44 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008F95C97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:30:42 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b142so8618407iof.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XOQ1w4vm4/BAxEC+jX3EtH/zHfW8KGtqf6yAkxCZrGU=;
        b=gcdkuigXVR/vglMBclXyxN6RKU1Cq6mDJqZck+kETu/wpBTgNg/NLwx+KVkgCiSTCa
         QnBaQMICJzda/l5FgnBEN6vk8KZoN0e8/6hW9nr8bmr+HdhOgDcbvfiPhxFUM096SsmS
         aabZxgI2yDhhk8IJbABimf9O4pDaxkZX/0ALC4cYNyQ+zGbklZQGJzyXqZ3R7fL25aCy
         hZvKl/PKJdoaLepvAWzauAspBgUcRPHodvQlaFu7cnJIapB6zTnDwwL4sYT6Mrlmjuj/
         D7i6BlTAiY5oTQsrDib61dL9iFaqWDAsIcuyaBPXxSHYgDEEHctyEMnoH9h3Aih6Oif4
         MIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XOQ1w4vm4/BAxEC+jX3EtH/zHfW8KGtqf6yAkxCZrGU=;
        b=bnLxrrAQeUdsycN/NcQF9J/K8nwfdhUNVjSEsiZJVoQNcQzuSZUmDkedPPT4jI3EGj
         mCGipjpdc/y9I7HvE52c3Nx3QBlUlcpGvYl+UAegy6FsHwZdJdJqfAtASc2SGDxCoTkN
         fA3k9EL8+gWv7T03QzRfEFN29nTDNMnMWtsLqVi8KYxx3ZVOAQUp+eBq/Qgkj+Hh/IiJ
         QSSd7yVKVnnIs5tjnDwm7/SYti6kISCX9t2ABEGpHnpKnVyyzGrUzJ6ICn7bYc+nfYqz
         VPI5A8RgjeZKOnS/a/MnTPSTrTLIgm1NAqRuMVFMeQl13JF0pObW6MaWy4bcMgfa243m
         l/7g==
X-Gm-Message-State: ACgBeo0Yal0W+8WqJFxfF/YJ4grCFA5Z4nj6jS/+CGSvndema506lbNN
        v1YwTcNnTa/f6vXx71z5OSV/sn3v78EAoyS2xIc=
X-Google-Smtp-Source: AA6agR6MMrtKGn8FUnHIBa7I3kqhhl++k8Y3Jd9D30PcbuoGF4u50BtNrbh/zQRgOvad1+8DaTFKulwW2xYhi2TMrIA=
X-Received: by 2002:a6b:8d8a:0:b0:689:4bb8:d59e with SMTP id
 p132-20020a6b8d8a000000b006894bb8d59emr10535278iod.16.1661848242253; Tue, 30
 Aug 2022 01:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220803151217.75962-1-ppbuk5246@gmail.com> <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <Yw2+H9MNpf3Ve0eJ@MiWiFi-R3L-srv>
In-Reply-To: <Yw2+H9MNpf3Ve0eJ@MiWiFi-R3L-srv>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Tue, 30 Aug 2022 17:30:29 +0900
Message-ID: <CAM7-yPRoBofD9+avRj1SH_GFogAnmJ7U8jJjbViH_hgOFBTX0w@mail.gmail.com>
Subject: Re: [PATCH-RESEND] arm64/kexec: Fix missing extra range for crashkres_low.
To:     Baoquan He <bhe@redhat.com>
Cc:     will@kernel.org, chenzhou10@huawei.com, nramas@linux.microsoft.com,
        thunder.leizhen@huawei.com, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Right, excluding crashkernel region may cause memory region splitting,
> so we need extra slot for that.
>
> Meanwhile, can you fix above code comment mess? Otherwise, this looks
> good to me.

Thanks! I'll remove the comment.

> Or we can add extra 2 slots like we do in x86, it just add another 16
> bytes temporarily.

Agree. I'll send the patch again by modifying nr_ranges' initialized value as 2.

Thanks!
