Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC51E4E5FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348701AbiCXHt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiCXHtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:49:55 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D07490274
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:48:24 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r2so4453123iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/EWBr8VYndoFsZhwJYu5ltpIZZxYhiAYyqvf85+j+KE=;
        b=fFhWdVH5C9Vw1EGBgAZ6wFnCnGosqlFZGd/EdTvCOwkrAbuqvdWpShET5c9NZCXNAR
         /vbfQ9cn7vlKkv8Dpcda8sSphUfip1fu9Lvkn9sCM6IzEP0DmVpRGz1vt8Ug8pHP/zeI
         UhIIkk3Yff54n19h5QoOHY7lIICCcv8w8Sj6b6+6pqN4cDclGanbyLgPlQaqgAMj0c3X
         mwejRrXCPWQKAv0BXCKN1kEWoMrlRBveg0Zs3aHik9ver62z0NXERrJm9CLurqltS3ur
         otrK5EOR5bBrOhWcZQkIK1MxIW2/3sty6YtRsxfHOFbo6eL/B+xzh/CSmSraZjKWXkrv
         E33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/EWBr8VYndoFsZhwJYu5ltpIZZxYhiAYyqvf85+j+KE=;
        b=u2lRO7R+Ek+tO3OrRgFDPMiwrlTp0Z2FEJRanle7N0NGPTzpGyoA10itbCSuGNn1MS
         NoEtNZcfmcq4Xxtaogf9IgTSP2w7hfxruzFzPFlVe9dFZVNGSV4Hro1rhTpuaPFG/E/Z
         pC6Tukrit+dNbEFPQZF6K5vVQu8c6zvm4YKh9w9sxlyfyXoZe1OlCd8bEMezBOzOLlFj
         SGSyK7NUZSr4quE6zxCVXBmfq7kDsipC9MmaLzvW76rrCt9BgmvpOJQ6EYt7mdGUffsR
         S13RDabnGvJqrVD6Y4VTAavnCJeocg1IU+v0lERAzJrNqOURvUU2jV5mxPBdWK/sGj1F
         umTA==
X-Gm-Message-State: AOAM532kCEuoXXb1TnNmGo42tvBAoi30stX7kuOTRHosLsoAM3OqX53J
        cJX3S7APMkckatjpMMamsjAu3zmEE7e+hw==
X-Google-Smtp-Source: ABdhPJzT3s0Q3Xy1K5FeCDl/XBsNPYGaSwsf+FL7i6ImBHxLK/KqWW2Ix3kivnQC0FiksAdgqL3i6w==
X-Received: by 2002:a05:6638:3e13:b0:321:446d:2977 with SMTP id co19-20020a0566383e1300b00321446d2977mr2275141jab.178.1648108103680;
        Thu, 24 Mar 2022 00:48:23 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id p66-20020a6bbf45000000b006499925f1f1sm1230513iof.19.2022.03.24.00.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:48:22 -0700 (PDT)
Date:   Thu, 24 Mar 2022 07:48:19 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
Subject: Re: [PATCH v5 03/22] KVM: arm64: Support SDEI_VERSION hypercall
Message-ID: <YjwiQ10CE5AtoM4Y@google.com>
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-4-gshan@redhat.com>
 <YjoPxLAMIPobBzS0@google.com>
 <d8e151e5-080b-dc87-b7e0-9031a7928853@redhat.com>
 <YjtLVqBbL0jyFFZy@google.com>
 <6f217836-45fb-8833-7bb1-5dc822826f56@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f217836-45fb-8833-7bb1-5dc822826f56@redhat.com>
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

On Thu, Mar 24, 2022 at 12:07:34PM +0800, Gavin Shan wrote:

[...]

> > > Yeah, I was sticky to the pattern of "KVM". However, I think it's good
> > > to reuse the existing one. Lets use ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2
> > > if you agree. Its first two characters are "VM" at least.
> > 
> > Sounds fine to me. The only other nit I'd say is we should define a
> > macro for it too, something like:
> > 
> >    #define KVM_SDEI_VENDOR	ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2
> > 
> 
> Agreed, and the macro will be put into arch/arm64/include/asm/kvm_sdei.h.
> arch/arm64/include/uapi/asm/kvm_sdei_state.h isn't the right place because
> the dependent macro ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2 isn't exposed by
> ABI.

The argument could definitely be made that our vendor ID should be
promoted to UAPI. Even though linux is the only known user of our
vendor-specific hypercalls, nothing is stopping other software from
using them. Beyond that, these values should really never change anyway.

It isn't a big deal if you add it to internal headers, either, as the
only known consumer will be the kernel.

--
Thanks,
Oliver
