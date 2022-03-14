Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4664D7D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbiCNIHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237070AbiCNICD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:02:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D316633EBE;
        Mon, 14 Mar 2022 00:58:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e13so12860832plh.3;
        Mon, 14 Mar 2022 00:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9NGaqnU5WKGBCSdUXb/re6i7ekcV7E4ukQg8QFjXiKo=;
        b=f+47SjE/WT3rYCIs/VBNHq+tnt+oBqJNBhKlhP3v5pbqsSjlsg1KAJbOBzwYshCUTu
         Oe5oUV82paRUAvtcKh1O7Dbn2UH98eOUFiTYVMlQ1r07NytdweJzIj52AKr7clWIGa5j
         evtgtfihJeZ4YphvwPJsRoq7/wBrVsKGEUg9i1u2+v0fIfK0Oqn8CLOST89LLa+uWtVL
         6Brc/fgYOPRZR5ouZGT8ZHIWYCVHTallvf5tuJBxVqU/zshI3307wWlyhhqQRMOETo2L
         h68lxwc6S4QjGphAYwdo0MdMO//ykl3iEwFwetTfJm8yxde4zOGKcZG900VeW/ERqRjP
         9qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9NGaqnU5WKGBCSdUXb/re6i7ekcV7E4ukQg8QFjXiKo=;
        b=NslJKRImmKTyEPHEolXvv/0r/P7MNtZdjkq/CTsbiACqaz6RAb95P22chOXk8HtQdw
         kfB7QG/81QfpbuAVuwRjaD3pbpwbeFrqhEkwJuxR7Rf/oqR5w0vrBneoUhsExf8vZI+G
         4dgMTpucvX8vfejeffa5IUl3F1SH/uGfg6/rbWTKao9HiuKJfEkLDV6ckEv6Gcqb0c9W
         kzJHbkTDsFftN4Q1hCACwpEDiP2i1ulxwR/BRnMq6A9UaibZICNhRk+gtLDmMqXa6AET
         pgHLJXg1uAsBdwULEY4R8HQFW4K1wFZk05pydAuFft9Obek2v5uModObzc7Mz55GGuxi
         Jgdg==
X-Gm-Message-State: AOAM533kQj1LLsREEtxtkExDLLQ9Q7mzGzFAzrLyj69O1/ihF44JqkTC
        mik8ElyWUwhcnWqhvATkkDU=
X-Google-Smtp-Source: ABdhPJyMEYuuP93Wt4kDxa57+ULt97SXAAu7ldWDqXEFX5Af/fOhK3uxxf6opMb661cL3vcFzB9A0w==
X-Received: by 2002:a17:90a:8c14:b0:1be:e8cc:96bb with SMTP id a20-20020a17090a8c1400b001bee8cc96bbmr35087522pjo.176.1647244712164;
        Mon, 14 Mar 2022 00:58:32 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id r32-20020a17090a43a300b001bf48047434sm16412408pjg.32.2022.03.14.00.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 00:58:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 13 Mar 2022 21:58:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Ming Lei <ming.lei@redhat.com>,
        Yu Kuai <yukuai3@huawei.com>, Saravanan D <saravanand@fb.com>,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: Re: [PATCH block-5.17] fix rq-qos breakage from skipping
 rq_qos_done_bio()
Message-ID: <Yi71pvinlDAqVik8@slm.duckdns.org>
References: <Yi7rdrzQEHjJLGKB@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi7rdrzQEHjJLGKB@slm.duckdns.org>
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

Ah, I forgot "block: " in the subject line. Please let me know if you want
the patch resent.

Thanks.

-- 
tejun
