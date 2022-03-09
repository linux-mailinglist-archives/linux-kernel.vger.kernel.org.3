Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312B64D2934
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiCIG6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiCIG6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:58:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF9B5161129
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646809043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uQZVhMRBRFZnnKX2zkJLC/T4eTixzo4LpDh1ov3v/B8=;
        b=WLWkIvBAmgGcYfmTSW0ZN/wwRriFlkVfcNsEZ4lluzWdZL+bYTgwIwGOkFER1NLVveVYvl
        s06BhZ6r5V2033THJIQUVvfZZkZeyzkJC7eBwI7I9x2rEfYpCz7X2R6aU4ilYXnQav/dSS
        s6GoEAb2w8afkorzVaMF2kXrcfi6dsE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-i36aYWzJO2O6ufpasZajLw-1; Wed, 09 Mar 2022 01:57:23 -0500
X-MC-Unique: i36aYWzJO2O6ufpasZajLw-1
Received: by mail-io1-f69.google.com with SMTP id w25-20020a6bd619000000b00640ddd0ad11so1196294ioa.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 22:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uQZVhMRBRFZnnKX2zkJLC/T4eTixzo4LpDh1ov3v/B8=;
        b=UBj9JxFae6nQpgEAm2PUzPvOe/g515CA/BgdOf2HzPz0Wtld05W8rf/LFrfHsaWB4C
         I41XMHuLMKvRMwpjhoYYxBPTawQZ6T9WIBFTfHaExtfLwXY6BgqY2Npb4q9qiObY43mW
         UQvDvK9PYyUjWLfoGQr/sKnEI+B1Jg1e80aeilHM6zvnqVA007icticXXVqrJVRMau/8
         dMBP83kRVVQE3jWPJMjuMVSaTEGmEMzq+aucrwOLMh8ta0nLuzPbfxjbMCNpe6UXANw4
         R3+iPw+0eHubgiP9hLv75nqG+debuygON/FpHEE1e/dcXlw2JUmzKXWr27BnRuK1dZeE
         yA7w==
X-Gm-Message-State: AOAM532zfjXCxpntWhofdU8mCClwlvwijrWw0/+hKa4+4TSCidBGrFuh
        zX545/zDPFP6kfDvASyY1g95pV2vO+yoyaTT8VvQqnYfFvqkvU7bLkJluSO1uquqGd7cmFXNNd2
        zEx0DcTGT2PVzmuohYUw1ZFCE
X-Received: by 2002:a02:782b:0:b0:317:ddef:fa78 with SMTP id p43-20020a02782b000000b00317ddeffa78mr4607889jac.226.1646809042187;
        Tue, 08 Mar 2022 22:57:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydiT/IcXzAEqQoDSaZupQDRdDRXGP1/vSHgDFZUSQ1ZWy+U3Vctkw+exsRQ+dmuJJRMFgHcA==
X-Received: by 2002:a02:782b:0:b0:317:ddef:fa78 with SMTP id p43-20020a02782b000000b00317ddeffa78mr4607877jac.226.1646809041893;
        Tue, 08 Mar 2022 22:57:21 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id m7-20020a056e02158700b002c61541edd7sm671684ilu.3.2022.03.08.22.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 22:57:21 -0800 (PST)
Date:   Tue, 8 Mar 2022 22:57:18 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <20220309065718.e4k2el2mlqn23yh2@treble>
References: <20220308153011.021123062@infradead.org>
 <20220308200614.gyhp657bdq3rxapl@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220308200614.gyhp657bdq3rxapl@treble>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 12:06:18PM -0800, Josh Poimboeuf wrote:
> As talked about on IRC there are still a few outstanding issues, that
> I'm fine with fixing after the merge window during the upcoming -next
> cycle:
> 
> - xen hypercall page functions need 'ret' - (I think you already fixed)
> 
> - why don't unreachables need to fill up the entire sym hole?
> 
> - get rid of the 'c_file' hack
> 
> - improve cmdline option intuitive-ness
> 
> - properly integrate the retpoline "demotion" with the new Spectre BHI
>   related patches - probably still needs more discussion - for example
>   we might instead want to disable IBT and warn

One more:

- Changing objtool should force a vmlinux re-link.

-- 
Josh

