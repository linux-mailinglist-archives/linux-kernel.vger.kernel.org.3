Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D843655A06C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiFXRst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiFXRso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:48:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7A141320
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:48:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n10so2762895plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zliD2Qsx7OubU1h4LVAM9OejLzFcsBaCjZJRdpEsKrg=;
        b=Pz4gqJjlBZdH2FUZf+LZ3Zk2c4Q5PjoLHgSJvUIfFCXLQ3s0DQzl2M7apET6Zy18l+
         gg0BY+PsbRil96ZfM2R0pnbNH0l4VO7BByOsiIJRLMuVeDsIjk5zBu5mdXPAuoNx6L7B
         hNj9RV6ELW7Ls1GQSQx6AOxZK02AhyVXkIwbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zliD2Qsx7OubU1h4LVAM9OejLzFcsBaCjZJRdpEsKrg=;
        b=hiQHIVPzwloOsiFOde1NAIewV0FPcSSQYfcRU+w21m2ilGO8or5CAGjxUv+w19xvpF
         FBag7jxx5MdQ6lV02RHrSut0OgxKISPYfSxuVgeLgmsKLaAy/HB6AMJSsGixA5R+EsV9
         0EtjVFTIlAbxByUMWWCRRhXONHW9Q3fb1duwri9v2nZaF0oe8nfvKRZEgW4glrC+3X4m
         LFt0b4/o1ztYqAjWOaB93YbvK2X0IQdSJ4kMM+l7TRWt/5Rj6LbAuhrOfmQ9IO5D7yLV
         1dNjxoo3OlVq/zkBlE5fue693JDd5UapwTeZ67ucCynVe3dwqLqFSUBqsJJBYZ+BzMKS
         fmaA==
X-Gm-Message-State: AJIora+Naq1Iz5hHUzoaIN1YntZcqPtgr0qB312D+CD5XHqs2iCvd7cq
        Mrmrit11CRKJmCgCR+pxR3kxPA==
X-Google-Smtp-Source: AGRyM1uURdhPI99lDJvqkOTCp86a8zulQKgFl/xro0YHHIZMRm4Fw3TKtsoXL4ek9b2CUpM+7eruIw==
X-Received: by 2002:a17:903:2443:b0:16a:2b65:7edd with SMTP id l3-20020a170903244300b0016a2b657eddmr332318pls.20.1656092921012;
        Fri, 24 Jun 2022 10:48:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902e9c200b00168ba5ac8adsm2111628plk.163.2022.06.24.10.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:48:40 -0700 (PDT)
Date:   Fri, 24 Jun 2022 10:48:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/4][next] scsi: megaraid_sas: Replace one-element
 array with flexible-array member in MR_DRV_RAID_MAP
Message-ID: <202206241047.903049ED@keescook>
References: <cover.1628136510.git.gustavoars@kernel.org>
 <b43d4083d9788bb746dc0b2205d6a67ebb609b0d.1628136510.git.gustavoars@kernel.org>
 <202206221457.1A12D768EF@keescook>
 <20220623014533.GA7132@embeddedor>
 <20220623031401.GA8896@embeddedor>
 <202206230816.1383511C@keescook>
 <20220623153825.GA6458@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623153825.GA6458@embeddedor>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 05:38:25PM +0200, Gustavo A. R. Silva wrote:
> Which object files are you comparing here? because I don't see the zero
> change when comparing the before and after of megaraid_sas_fp.o with
> the change you propose.

Hm, maybe I did something wrong. But I was looking at megaraid_sas_fp.o

-- 
Kees Cook
