Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39B650A756
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390885AbiDURr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390881AbiDURrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DA7B2ACC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650563102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y85+6pw41kbzffV7AbcQ383URpp068z7QwvGuQiAdfo=;
        b=iZzaRVfIFxyu6cH5pd0YyAz5yYAPX9vo0giIK/yaULW7lwF3k5nc6mGyGNyQZ+9WgzJpnB
        tU9cmm6yFV5RosDVL0fnril/nmTBD1l5hbPlMPfhpxrwkkvS1mIbG69TbTl3/GEZT2n1ou
        XZR3BhFNtBX1bNgng+YuCnCsJly+PC0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-JbyChqxIMSmi6eHbqIjvZw-1; Thu, 21 Apr 2022 13:45:01 -0400
X-MC-Unique: JbyChqxIMSmi6eHbqIjvZw-1
Received: by mail-io1-f72.google.com with SMTP id x13-20020a0566022c4d00b0065491fa5614so3774508iov.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y85+6pw41kbzffV7AbcQ383URpp068z7QwvGuQiAdfo=;
        b=wLpWN7Vv/ue/AfblUD1b9lcbdAG6NA6SBk0K9qo/2hjv8xPmTI0n5tJ4MtjaFYquvD
         5LLCBiZGI+sYHFnjIU7BUzrvRDdnKolNbj+lXY+CFz/aq7XjhGgLiEfgilB5pPvdkHgW
         1rpI+3sJoG68SVhaFw4qJrUx2t+tiAFsHpCFGnFNT5SycVMVLvkTx/FZpTkCyuZHrGGR
         +vGN0vgOtmhKV8pR6EQ84CWGL6EASSkW1oZJnd80m5WqqYzd6ffYKHFGfXEWKv5lMNIm
         LoZJypm5C4TAaYCgx5IlZiFyny2sEIfDPCfN20FnpQmR9lEaEoYfZdnk+KdJ+RSzklu9
         +2DQ==
X-Gm-Message-State: AOAM533RDVsiaxdJ6CP+4voz+CHe5RN7Zx7rOMFkzIWscAdKXPpVr8t/
        XMHL8biJn510mVfO/CMskHK2pmmP8nYwGED/htt6fI7yUZa+M9hH1IbL0wheHcfnK1qD3bPcrad
        HVDO35Eoywj+I+vTm+QHkXBDa
X-Received: by 2002:a92:bf06:0:b0:2c9:b21d:6db7 with SMTP id z6-20020a92bf06000000b002c9b21d6db7mr402158ilh.222.1650563100051;
        Thu, 21 Apr 2022 10:45:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNjQU8wehmsvLvkrXczfzhPEQN+KmNB8g9/3LZORPgKu188DGWDpaGaZAfFNWhz6RszU0w9Q==
X-Received: by 2002:a92:bf06:0:b0:2c9:b21d:6db7 with SMTP id z6-20020a92bf06000000b002c9b21d6db7mr402146ilh.222.1650563099816;
        Thu, 21 Apr 2022 10:44:59 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id a9-20020a926609000000b002ca50234d00sm12250347ilc.2.2022.04.21.10.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:44:59 -0700 (PDT)
Date:   Thu, 21 Apr 2022 13:44:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH v6 02/10] KVM: selftests: Read binary stats header in lib
Message-ID: <YmGYGXlNdSEeFeeo@xz-m1.local>
References: <20220420173513.1217360-1-bgardon@google.com>
 <20220420173513.1217360-3-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220420173513.1217360-3-bgardon@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:35:05AM -0700, Ben Gardon wrote:
> Move the code to read the binary stats header to the KVM selftests
> library. It will be re-used by other tests to check KVM behavior.
> 
> No functional change intended.
> 
> Reviewed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Ben Gardon <bgardon@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

