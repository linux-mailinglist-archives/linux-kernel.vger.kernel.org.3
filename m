Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF3B5A1943
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243600AbiHYS7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243388AbiHYS7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:59:14 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A715EBD2A1;
        Thu, 25 Aug 2022 11:59:13 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-11cb3c811d9so24417111fac.1;
        Thu, 25 Aug 2022 11:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5/osOkrVUQsgbcBufQHFEfWH9eDNx7AJ4QrfpR5pmts=;
        b=vAXDuhLVEW1ZD41MDGLJ0F4h1TEwa9JlOOPY/67sc0KpL0QVYxW3uUY6yay+67BjpU
         eznGwOO80J8a1mdBzazwEzJS/4Ud/mC116/GS1Kbu0HEQ93PcRZxbDlMvvVmiffwXQGq
         iHSa6YkJ1QDcUVGPsik/MahpiaSdoSVpYdStMUFbd0J0yPrv6pfvmRm179URRbnEhlOl
         f5nInbVZCgz5a026hsmWb6NlGH65qQnJMkKUVSwJR5B/wYOcMhcijh3Y2Ir8/6sT2RqO
         V2x1wsqE9JNZRBzg3LTciALGWs85GWap9VtDspe4rV/q1AP2HhR4uDrzmjuYMU9A7CF0
         LPjA==
X-Gm-Message-State: ACgBeo2dtj+q46yQzwr2tuZK6Uo1KmBbMuMR0Kx8OCYT6zrJKaB+TyMy
        KYuOu2kV/ofxMPvyXJiRYQ==
X-Google-Smtp-Source: AA6agR562PllbRNd5yKNBPGQ7UncAfpgdrSo8yObUS0w4SpkphfiNrYliw5m8SU0REt6EHEnvU+jaQ==
X-Received: by 2002:a05:6870:9709:b0:11d:3823:fca6 with SMTP id n9-20020a056870970900b0011d3823fca6mr232375oaq.24.1661453952894;
        Thu, 25 Aug 2022 11:59:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j8-20020aca3c08000000b00342fc99c5cbsm24582oia.54.2022.08.25.11.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:59:12 -0700 (PDT)
Received: (nullmailer pid 1498402 invoked by uid 1000);
        Thu, 25 Aug 2022 18:59:11 -0000
Date:   Thu, 25 Aug 2022 13:59:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/1] of: unittest: taint the kernel when of unittest runs
Message-ID: <20220825185911.GA1498335-robh@kernel.org>
References: <20220823200152.3465751-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823200152.3465751-1-frowand.list@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 15:01:52 -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Make OF unittest trigger the new TAINT_TEST taint when OF unittest runs.
> Due to OF unittest not being intended to run on production systems, and
> potentially causing problems (or security issues like leaking kernel
> addresses), the kernel's state should not be considered safe for
> production use after OF unittest runs.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> Follow the precedent set by KUnit tests in v6.0-rc1:
>   commit c272612cb4a2 ("kunit: Taint the kernel when KUnit tests are run")
>   commit 2852ca7fba9f ("panic: Taint kernel if tests are run")
> 
>  drivers/of/unittest.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!
