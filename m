Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8238C4C0CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbiBWGsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiBWGsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:48:09 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411776D963
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 22:47:41 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s1so474476plg.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 22:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2kkz/9M1onALAAWffq1sVrSihrnFb1SDQgEEdEX1u0E=;
        b=meQO/Pybsai9Dc3J9kSlpp9AsPFEfc/fam2nBeHow4zV8J5aFkpl08s10ISrCNaqmw
         6bssfjN2O3AG7C1Lzvbsct1Y6fp/6S6g9DfGZuhZuKA9X7x8S3voYodXtNTvT5Cwg5qE
         svs8aTNlMK1OFe3jxXqtk1y9kVPGJUUHR0aYqrglcPQcehyqTQBIpi2OQenjnNEBOeGg
         hj2LGbTjG3oLqQOxCpJU7LA2hpJYHKa1Cqhfh2HxLLHWcsdepLl3PGT/7CRUe+CWnf7t
         JBWh8yH5LxHlZQudVhKSEk1JbY8FkiiBjAW3WXJQumC9h1ya/XHZUAs4WFukdKAEg3rv
         kBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2kkz/9M1onALAAWffq1sVrSihrnFb1SDQgEEdEX1u0E=;
        b=R+r5pnU79AOU3Lv4s4OJo1JSgTUwRpOoBT/ADHx9Rp2Xac3va0k7x/sBNV8UvxJxy8
         s7KaWKvHFPoS4HWpeZsQAqdtfi6PtottUxedGLd0XESlqVQDNMSrkyh3v/e70kbN1Ed2
         6P2dwKRD6edbAswDTlYDR4j8WPEKgsRbHNp53j2fS2taGrJ78iQ6JPeYyg3+vUmYubjc
         z6NEMO7YlkYGcvmHKE7YOZ5WvcZadQsUUsPtU5G0Xg/uLkWK7fi8B13pyLQEH7Q21el/
         oGb+bPUX5IR5EYetFyTE9aDkqlegLDA1SRCIcyB/hHSj5YL/rvym5p6HmkQh4QsxrMTf
         Z4yw==
X-Gm-Message-State: AOAM531J8g8XrdW54UBIIrnt2IsJRIABTonxmFMt1/O5aOlccI1Q47ie
        fa8npBH+AC+fFwQIKK2Tb/I=
X-Google-Smtp-Source: ABdhPJxor3Epj8osYAh5teNu4IhFDUTSw+BzeLG++VMnLBnFivzFKSIuZFBH6eZG3D0BbfxebGK98g==
X-Received: by 2002:a17:902:cec5:b0:14e:e827:a6f3 with SMTP id d5-20020a170902cec500b0014ee827a6f3mr26105120plg.94.1645598861423;
        Tue, 22 Feb 2022 22:47:41 -0800 (PST)
Received: from ubuntu.huawei.com ([119.3.119.21])
        by smtp.googlemail.com with ESMTPSA id ls14sm1735611pjb.0.2022.02.22.22.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 22:47:40 -0800 (PST)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     jirislaby@kernel.org
Cc:     xiam0nd.tong@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt_ioctl: fix potential spectre v1 in VT_DISALLOCATE
Date:   Wed, 23 Feb 2022 14:47:34 +0800
Message-Id: <20220223064734.28874-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e0071c1e-cc20-e000-0673-f98e6f8fc316@kernel.org>
References: <e0071c1e-cc20-e000-0673-f98e6f8fc316@kernel.org>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 07:56:13 +0100, Jiri Slaby wrote:
> Could you add a break; here and remove the else branching completely?
> ...
> You could simply do:
>   arg = array_index_nospec(arg - 1, MAX_NR_CONSOLES);
> and remove
>    --arg;
> completely.

Already adjusted as suggested in Patch v2, thanks!

Best regards,
--
Xiaomeng Tong
