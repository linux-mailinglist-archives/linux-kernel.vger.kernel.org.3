Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA3D58439D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiG1PxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiG1PxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A25C46BD42
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659023594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=CR7W8yzle9Zr6nPa3nWK0fbYLGoAXfhatxVa3PcQEOnfHlNL3N53sWk0hiH4MWKad2nh/E
        59aZW5AU9W/hgptHHpgeQw4+ldnMUlsMdGVabDM7mZ3/SxURgQ2T3beFYGdHEKh15RzRVf
        tcMTGMmYbZItnL/Ao9Gtk3TtkXVvOrw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-olAj2n4-PheOrD8EZVlfTA-1; Thu, 28 Jul 2022 11:53:13 -0400
X-MC-Unique: olAj2n4-PheOrD8EZVlfTA-1
Received: by mail-ej1-f70.google.com with SMTP id hr24-20020a1709073f9800b0072b57c28438so766737ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=gyf9fVMSna5FqvCLa0eVQaK9tfxJhwwolZ/piTAhqHXbeQrU33VVhDqI4NN9ZD7s2U
         Y2t9hYq4kr5BhIA5p/XrQsHVKz97QzYdbe7FhuQxQGFfhlOf2PH10Asyu+VNzMKMhVa8
         RZsCoILsxkGv7tOD51VVdldOIdmYdGQ/iy+6Cafb7r2iWXq7FUIfirO7QeJYzUGO3rZz
         8OkFsN+9KwviMT86NGAkHCQXGLPvkw8F+owMJbmcmYqYeLRv566F1Smv7IHeUcaXARRY
         agYJRYumJLqJb7VSyYONY2i3biayQsRnQci/idaEWqMReFfBkegU/j6b8im57oFKLWwp
         ZA8Q==
X-Gm-Message-State: AJIora+0UzkPQnkXwtyFSt7bHbR7sshdXHf9Rx8pWWhulsfE5fldI8Nq
        rFhIjkj9H3H85wditxhEqgzD8V3RSSMHctUJLrN1JoHgwyODdHWEcc2LvSr3wXus79VhEaO/QPn
        Ilzf5rSHRXi/Rk5X5pz2GgOj0
X-Received: by 2002:a05:6402:11c9:b0:43b:b905:cb88 with SMTP id j9-20020a05640211c900b0043bb905cb88mr28005157edw.102.1659023591967;
        Thu, 28 Jul 2022 08:53:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQ0WGkcljQ8+LQm9jJHKMMx05xV2P+kXpPzT5FmSEfnOq9qHwys5h+KfxqBoBs5xEkKeffGQ==
X-Received: by 2002:a05:6402:11c9:b0:43b:b905:cb88 with SMTP id j9-20020a05640211c900b0043bb905cb88mr28005135edw.102.1659023591576;
        Thu, 28 Jul 2022 08:53:11 -0700 (PDT)
Received: from goa-sendmail ([93.56.169.184])
        by smtp.gmail.com with ESMTPSA id a12-20020a170906368c00b0072af890f52dsm548037ejc.88.2022.07.28.08.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:53:10 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Jarkko Sakkinen <jarkko@profian.com>
Cc:     stable@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer : X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "open list : KERNEL VIRTUAL MACHINE FOR X86 KVM/x86" 
        <kvm@vger.kernel.org>,
        "open list : X86 ARCHITECTURE 32-BIT AND 64-BIT" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86/mmu: Fix incorrect use of CONFIG_RETPOLINE
Date:   Thu, 28 Jul 2022 17:53:07 +0200
Message-Id: <20220728155307.277425-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220728000221.19088-1-jarkko@profian.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Paolo


