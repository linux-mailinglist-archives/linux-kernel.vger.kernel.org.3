Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC1F4EB12F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbiC2QCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbiC2QCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:02:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661D44F9DA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:00:21 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b15so16292043pfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wLB2W3osImGhGJhaelfrrl2LJO+fbxoOBdPBcEx9ObQ=;
        b=JZaM5Vq7+JRpy2GSyBX4fyQL8BtT4q/Ds04omeAeww5zu7GQJF00I4KSNbXALL3qo6
         l6mS0q1N/9iftzMMKjWWz0iY8pHn5gMEIRCSzoc0l20Ona/1FfxHMI7UoI78CctQVjik
         OTRlsyMVIDTQzYffJAXnWkPXMvX0kszXdMsnWPZtECBRUCOAYi2jMiUFtsSGI1gpEFal
         zjrosQfkEzD64WJ2iJoTBnJeElA/GI2gCrzjaZhq3hj52rj3hE1WjiX1bsNPq+C5nkIW
         RsArynBJaXNXbFbyEuxU7qB7TshuuS8BZo6Vmr1kSfjX0FwPzAnA1ZCdduuUiCHCE7I4
         tIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLB2W3osImGhGJhaelfrrl2LJO+fbxoOBdPBcEx9ObQ=;
        b=c9GOIUCdvgY2U2GIHc/qCV6CQ7+NcdCrW79rXQ5+QrVmTQo56KQ00rPnItCIGW4A5P
         AWL0wNX6gOIJxkr2cqsrmgrfnBbthAKxslrFZ+buH4W/AVCdNnaxa9I8jNGS1IL5g3kf
         35QZvd4ycwT75m/rY6XV2QQVgYuG1ZiTUR082iIRIRkMZkvtBZQRNLko5X+KPhTTLqO/
         35E6hdlZMll1ejiDgBlYc8sEoXMXf+y/7pAnKhCU1QJij7D1t87aycoPhFNvWVqgu6pZ
         ZS7ugCtfa6KikVCqIO/iMaDYFrJerb2I+hUK+xlpE+aR219eFHaTlWbyhOw9Bgwox2Tz
         F6sg==
X-Gm-Message-State: AOAM531rSm63PVW69BJKzN+7h995+tZZSZ1Qdwfwory1dcHzKTZJ1JwL
        gMGHxPVJ50Py7lUW2LZrE14S+g==
X-Google-Smtp-Source: ABdhPJyTEGo4uZQmZaqy/0CyrEK/6mMUs5+9yBIjB8oKSkFj+nqe8SSLPBy/gtC+S4bXWS2oDsi5TQ==
X-Received: by 2002:a05:6a00:15d6:b0:4fa:f217:e2b2 with SMTP id o22-20020a056a0015d600b004faf217e2b2mr25789174pfu.64.1648569620394;
        Tue, 29 Mar 2022 09:00:20 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q3-20020a63ae03000000b003820cc3a451sm16503909pgf.45.2022.03.29.09.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 09:00:19 -0700 (PDT)
Date:   Tue, 29 Mar 2022 16:00:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     SU Hang <darcy.sh@antgroup.com>
Cc:     kvm@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: VMX:  replace 0x180 with EPT_VIOLATION_*
 definition
Message-ID: <YkMtEIu8+g3DgPG5@google.com>
References: <20220329030108.97341-1-darcy.sh@antgroup.com>
 <20220329030108.97341-2-darcy.sh@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329030108.97341-2-darcy.sh@antgroup.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022, SU Hang wrote:
> Using self-expressing macro definition EPT_VIOLATION_GVA_VALIDATION

Nit, this still refers to the name used in v1.  With that fixed (Paolo might do
it for you :-) ),

Reviewed-by: Sean Christopherson <seanjc@google.com>
