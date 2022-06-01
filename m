Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F002953A338
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344121AbiFAKtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352292AbiFAKtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8FE282155
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654080533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hrH+2QAikayivhZwVSMboNGmELij4yc/hiwsqHY23jQ=;
        b=jUPo+16xlx3rXbDoqshhdDwwStThAk3TIY8eHgteyHiGhjwVZAFEWzDkgAV1PJk+fn4E6u
        vJH6jJT+GFTEz+ZPF3twkG1kTFvcHww9QtN5YJFxuN1G1FLORartaUVgMU0+7t01E+n5tW
        W4Aoq5mU73xunsax1lIwESkwJ6cfS88=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-cvQ4Fq35P_eWrTnnUxQ7vQ-1; Wed, 01 Jun 2022 06:48:50 -0400
X-MC-Unique: cvQ4Fq35P_eWrTnnUxQ7vQ-1
Received: by mail-pg1-f199.google.com with SMTP id f9-20020a636a09000000b003c61848e622so886794pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrH+2QAikayivhZwVSMboNGmELij4yc/hiwsqHY23jQ=;
        b=aNCz86XKBgQ1xxosZIqBryURzPq0KYQgPxbbaMD0nokynqGmk0qqmB5yfzRdw0LDWY
         QNWfzaRS481oxfCvlm+iBGYf05lRjPcrx4OuBv2fEcEIGVfL3GK0biSYeA/o3PJbpy8I
         QTD1N6RGFovza2PTKOFcrFFNKwXYEe24xMDCYWPAtPBmhtLQvpIHdc8jrQDAXF/KzQ/G
         8MZNJvDd82QAUGN57OeBpJdeSpW/2X3e5bVe5NXqx1hq+aQ9ZgOMy/5vM9X7c2ajXJgz
         DxCjR7bf2lpm9PptkOEBTuOiKubpQ/NpXasysjwqzWjpwbH6pyhXbFehNiQPLIF7ixla
         h1kQ==
X-Gm-Message-State: AOAM533D1M5RukOn6Gb6j706+Wej3Z1VXqtt4LkaWCy/qHoyBxX5mitz
        VSkA9KOhrA0GV1E2Jg/6PMhzx98+PYj3/PVyhVgo/A42F+rm/XsAN8jlvGy31UZdyB9bNEHSw+V
        Xu2JQ3Q2Sh8CdcE7M/9SAvOlM54an+HRCqkg4Lkyu
X-Received: by 2002:a17:902:7c0e:b0:161:f9f6:be5b with SMTP id x14-20020a1709027c0e00b00161f9f6be5bmr55846790pll.156.1654080529835;
        Wed, 01 Jun 2022 03:48:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8Z/R1QPBiL3zZ58Z7WbyHv1cLTETgAEl2rVhWxKGRnsk8bKpXpXQqWNnB+kkOIRq0CkwtBCtdW6dm6n516Mg=
X-Received: by 2002:a17:902:7c0e:b0:161:f9f6:be5b with SMTP id
 x14-20020a1709027c0e00b00161f9f6be5bmr55846774pll.156.1654080529546; Wed, 01
 Jun 2022 03:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220531075540.14242-1-thuth@redhat.com> <YpZu6/k+8EydfBKf@google.com>
In-Reply-To: <YpZu6/k+8EydfBKf@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 1 Jun 2022 12:48:38 +0200
Message-ID: <CABgObfZ8LipJXh28xjRxqZPyNX1muP=_fYdmH=a9hvQh7eq32w@mail.gmail.com>
Subject: Re: [PATCH] KVM: Adjust the return type of kvm_vm_ioctl_check_extension_generic()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas Huth <thuth@redhat.com>, kvm <kvm@vger.kernel.org>,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 9:39 PM Sean Christopherson <seanjc@google.com> wrote:
> As for KVM_GET_NR_MMU_PAGES, my vote would be just sweep it under the rug with a
> comment and blurb in the documentation that it's broken.  I highly doubt any VMM
> actually uses the ioctl() in any meaningful way as it was largely made obsolete by
> two-dimensional paging, e.g. neither QEMU nor our VMM use it.

I think we can just remove it, or return 0.

Paolo

