Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96975A0EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbiHYLGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbiHYLGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:06:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C030ACA1A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:06:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k9so24148061wri.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xDb+b/m0n+klNI3MyZmJA3s5Vf7qTobkubvvQlKUrhA=;
        b=Xg524UvqkXEorDOgtptPoBihbU/PP92MM0wPjghBTh3BoTLqbi0Crj9DZg9aXoOGq4
         Ec6RdzTjbKiokXnx6oDwXu153+UGLhSswQ5QHMISH2JBHsXksC+9p8WgIrdqBaUM0xd9
         pqo8PTo1kIGZ9OQz/65ueP7qPkzJdyfjGIXjGQOgKnD/LB0JhO28JCJChlwnoWTIHHpF
         CSYkPZQaM+Y0gwLOyLiKDp7RVTIxN3mwdDiNlSMsi1mkJAuMoc/ADJrKaspHyX6GFnGV
         fLBd3BqLYQYJQgv6/XDo2B2y96xfvwqHJLbPgt4jDCOKoko42KdfjReQQNp3Tf72erBl
         IndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xDb+b/m0n+klNI3MyZmJA3s5Vf7qTobkubvvQlKUrhA=;
        b=VpB+d/ChxBOtJu2Sqwvj7Ko3TiAmGfHy04obOxDE7xhIMRAZVAsNPicsFM2smEhXTb
         cfvnGb6tM5P7W+7cfqEzyhV12zCAEd+RZXRZUPRMNT9IE8XtVKrz48bYfOguF31+y2nd
         JbvXMkNyum4N9pjTC3ECLyKooB9E5o/VjFwPw+MaaF77OK73cEzkVKCfbLyNFV2R2ECg
         k75LlYkQpbrzI/GP48oQuMJ2QBkTKm8ozOHU3kffihTrGBNhybK44jEZ94hgrCY0BiiQ
         aPVIY7caYCW7Dsu4XGsRVh+NMhcS9nHUA8PsXOXM4Ph+uXyTjRPB3kv5vfExJ/01+CKA
         XxIg==
X-Gm-Message-State: ACgBeo2Fdp5A2xJ2AsA+LNg2qwdGowVJETv/V5A55qY5VFzqqOhuXU/w
        5exHggqVmYzXNpxEL3Y75x9pAg==
X-Google-Smtp-Source: AA6agR5wgTb85p6m68rmlF+R4Hb/Df4DO0dJEpedMfqx+JgbG58cN7d+hykqeR5FWUVhpIfFsRTrQg==
X-Received: by 2002:a5d:634f:0:b0:225:2ab4:d539 with SMTP id b15-20020a5d634f000000b002252ab4d539mr1864694wrw.149.1661425563745;
        Thu, 25 Aug 2022 04:06:03 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id a17-20020adffb91000000b002207a0b93b4sm19426496wrr.49.2022.08.25.04.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 04:06:03 -0700 (PDT)
Date:   Thu, 25 Aug 2022 13:06:02 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Conor.Dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v2 2/2] riscv: extable: add new extable type
 EX_TYPE_KACCESS_ERR_ZERO support
Message-ID: <20220825110602.bog5mjpascvikwxx@kamzik>
References: <20220815032025.2685516-1-tongtiangen@huawei.com>
 <20220815032025.2685516-3-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815032025.2685516-3-tongtiangen@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 03:20:25AM +0000, Tong Tiangen wrote:
> Currently, The extable type EX_TYPE_UACCESS_ERR_ZERO is used by
> __get/put_kernel_nofault(), but those helpers are not uaccess type, so we
> add a new extable type EX_TYPE_KACCESS_ERR_ZERO which can be used by
> __get/put_kernel_no_fault().
> 
> Only refactor code without any functional changes.

This isn't quite true. __get/put_kernel_nofault now sets a different
extable type (as the commit message says). But, nothing special seems
to be done with that, so there's effectively no functional change. Can
you please elaborate on the motivation for this change? Where will the
KACCESS type need to be distinguished from the UACCESS type?

Thanks,
drew
