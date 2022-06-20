Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847A255118D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbiFTHeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiFTHeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B70B6AE76
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655710441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9O0CIqeEaoJn03vVtSYdv9IsNbaraVCXGcehJj6LilQ=;
        b=BfDApnmT7TD6h8hYXmbv84ET73ro96bm2Ug/mCPq5iB4RInm64D8HKG8fbCuxanbWgfu4R
        demVSV+8TVYb0h3CyJwbhrJhqpLtEkWcxBSNOH3ALvS0h7pMYVDofQPZ54lGeYg5RPuwfp
        zMWHp7ybxz7SqLs/zoc0K6R8T23/K2g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-F-p-ug5mPU-LDTh9sa8ODA-1; Mon, 20 Jun 2022 03:34:00 -0400
X-MC-Unique: F-p-ug5mPU-LDTh9sa8ODA-1
Received: by mail-wm1-f70.google.com with SMTP id l17-20020a05600c4f1100b0039c860db521so4666309wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9O0CIqeEaoJn03vVtSYdv9IsNbaraVCXGcehJj6LilQ=;
        b=iDzJJK3XY2NmZbclufCMI84QlT23Tf52033CAtfkFsbA6bzqxOV7UD/HY4LpoJt/KI
         h+svJ6HrIkgrvSgTgYP1DAagCEsVNG11+EH9QgRJD+sjzDlzdvPtuRmD7cMAH2aXQ4Yp
         PWlwU+SlIrkPpSO8u8G8wlhZnDeoKHQLlmcE7Z+XfzqVnicl3/tPgZwlL+g89/1D+99y
         4+2IvuSz3Lir+j285gTTRs7TnflciEFLJtfE84tQ5ud5egtiUxlWaYKa7dn0dqpzDPxN
         4wj7Ly6qkhLn724w92AdmCLKiT6PntINRkSaDnDtmzjj+hy/WV/zEU3FrnqOrvhMSKwT
         k0ZQ==
X-Gm-Message-State: AJIora+9G6yOxL5toaYH06pxfaBens1IJBFP7qNgNiaEGhbCi+JLHT4r
        bi62KPqebmLatr7N4pDtABFNBuUccyS3v6bT31MUrgss9+wkDCZmc6Il8eWGYGPYb9Gjhw0EfRZ
        YGL6xBv+qmVq7Ygg9jcisTcPB
X-Received: by 2002:a5d:59ac:0:b0:218:5b7e:1c1c with SMTP id p12-20020a5d59ac000000b002185b7e1c1cmr21891416wrr.621.1655710439273;
        Mon, 20 Jun 2022 00:33:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vkewhJzwIOJ9l+/yqE7pUpzblIRdbrwtFQigT8P4KR1GnlkLPaHlZsigHVgHZi02aADaZXLg==
X-Received: by 2002:a5d:59ac:0:b0:218:5b7e:1c1c with SMTP id p12-20020a5d59ac000000b002185b7e1c1cmr21891397wrr.621.1655710439119;
        Mon, 20 Jun 2022 00:33:59 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b0039c96b97359sm14054471wme.37.2022.06.20.00.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 00:33:58 -0700 (PDT)
Date:   Mon, 20 Jun 2022 09:33:56 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Subject: Re: [PATCH 0/3] KVM: selftests: Consolidate ucall code
Message-ID: <20220620073356.fmtsa4ub74igm7me@gator>
References: <20220618001618.1840806-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618001618.1840806-1-seanjc@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 12:16:15AM +0000, Sean Christopherson wrote:
> Consolidate the code for making and getting ucalls.  All architectures pass
> the ucall struct via memory, so filling and copying the struct is 100%
> generic.  The only per-arch code is sending and receiving the address of
> said struct.
> 
> Tested on x86 and arm, compile tested on s390 and RISC-V.

For the series

Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks,
drew

