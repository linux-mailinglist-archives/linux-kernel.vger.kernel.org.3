Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36555534B9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351706AbiFUOlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349156AbiFUOlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:41:08 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1524F24F00
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:41:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso13593179pjh.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JOicc8moSgPUHZwRa0UCLUvVifYA0qTN8DaBzCizOgw=;
        b=cKCuyyDnkfNQBL6avZcuKqgcaAnrDgGaMrPVXHKS56JghxcscK9NoNnj3Fq7/NVRC+
         oRVzrbe4sEZRyZOqRivaOWFZO8Gd7vthX9YgbDCc1RkeiGegxd0pyZQqGZ/UzgMt5ruJ
         MaD7F/sfEkQoWFzd4qxP745PX7p+Gml77tWHRrjRjkZiJB4Si0+QNOhldE61LLtgrKtz
         z7nAckxCBVmBlyIGhrdH+2BUYxEDwzsjv/pBBt1WZ1hcXBLEmjxXq9UXzk0BiNzqacIe
         VkYCNWJt/9iPC5J8GLSnvPOdHVjKAoDqjVqKQeMuB+EOm3tQprFc1Ew0wMXup3tiDdCK
         rfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JOicc8moSgPUHZwRa0UCLUvVifYA0qTN8DaBzCizOgw=;
        b=8GvV+D5UK30liz3V5u0XeN3RKl34hJKAJgnpR/pq4Ol/hQZU0T0fAcWvQdf4On3CWK
         mRZrlbknZR56NvoUGJMd2mtzQhn2MiIpwfMPQ0Gpx8a3zlJW20TAHQrppHSg6jHRX6GP
         uwcSDbJ1aVdJuBeFu29NhO4ulGXlq1PinQtj7PY2z7mW/A5jp6yVX82cYs2AOayyTloZ
         DrHX5tF0WvJ6fTIWZC4O93LwJEUDv/RUglbY2lMgV0VVpvEbm9Un32Bb394e6Ko+ySIg
         00bAeIev9PMBs90d9VMoUnupjaChWDmnj4Cn/QzThKXXIOPE3sxMpNewSEpsKD/vUd/z
         zCew==
X-Gm-Message-State: AJIora+DBknNLOpsA+/9i0MiTCZEpbODLXHUVXC19UJkM16Tkj3oOS3N
        koRBKoNRA3U9aUWOSTgCzG7GJw==
X-Google-Smtp-Source: AGRyM1vJrRABFv+Um9W+VY7dY1s+g55BsfMNsbio+5fYQj4/zIQK6olfXAORs7KW0GbN7wK+7Xjx+Q==
X-Received: by 2002:a17:902:ab87:b0:162:26cf:bf7a with SMTP id f7-20020a170902ab8700b0016226cfbf7amr28637304plr.168.1655822466277;
        Tue, 21 Jun 2022 07:41:06 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902c65100b0016a091e993dsm8269986pls.42.2022.06.21.07.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 07:41:05 -0700 (PDT)
Date:   Tue, 21 Jun 2022 14:41:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Huang, Shaoqin" <shaoqin.huang@intel.com>
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
        linux-kernel@vger.kernel.org,
        Colton Lewis <coltonlewis@google.com>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 2/3] KVM: selftests: Consolidate boilerplate code in
 get_ucall()
Message-ID: <YrHYfiI+54hAp0vv@google.com>
References: <20220618001618.1840806-1-seanjc@google.com>
 <20220618001618.1840806-3-seanjc@google.com>
 <de35d629-e076-e02d-7482-c93de628dd82@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de35d629-e076-e02d-7482-c93de628dd82@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022, Huang, Shaoqin wrote:
> 
> 
> On 6/18/2022 8:16 AM, Sean Christopherson wrote:
> > Consolidate the actual copying of a ucall struct from guest=>host into
> > the common get_ucall().  Return a host virtual address instead of a guest
> > virtual address even though the addr_gva2hva() part could be moved to
> > get_ucall() too.  Conceptually, get_ucall() is invoked from the host and
> > should return a host virtual address (and returning NULL for "nothing to
> > see here" is far superior to returning 0).
> 
> It seems the get_ucall() returns the uc->cmd, the ucall_arch_get_ucall()
> returns a host virtual address.

Yep, get_ucall() then does the memcpy() from guest memory via that host virtual
addres and returns the resulting ucall command.  The intent is that the arch
hooks are not to be called by common code.
