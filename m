Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C52C546C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347127AbiFJSEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346245AbiFJSEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 282D5B4B0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654884245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uZZMSYsxNi00mISt/w3TR5/PXiZxHkemYMMPWE5iiPc=;
        b=Mnee0qtMvzb7FKqTSZfbZ9PFSqnMsnqkR5yo71n3hWxijtlDgtirMy+ApiaGxHohlIU7ln
        OD6Sq7SRhVV5QHm8BhbTjG9hHcdGekTmBeF+4pITQLOXkDuEFL8aQNoM5zyf7ZuyOSOAnl
        Fdm/YXxRjXMDn7RwOWtNNQ3tpcREC88=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-N3MnL7AcObeNw9IZQQV2GA-1; Fri, 10 Jun 2022 14:04:04 -0400
X-MC-Unique: N3MnL7AcObeNw9IZQQV2GA-1
Received: by mail-wm1-f69.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so27618wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uZZMSYsxNi00mISt/w3TR5/PXiZxHkemYMMPWE5iiPc=;
        b=6cHQc7fnmegha8enM0siAH+wauSmHgqtJOPRmGXOYXCcC+t+oA04ERYsDo0ahSgygK
         Rf5feuxfGT/m+4QoTbg69NXBBFux8rIDHzFTHvPzjek8aucgfse/oRtISiCRzh7IWT3D
         x/NVRdNVsLXZ7a1wLf3tdsCX5GLUouSHxMvto0R52sKVSV7Yw05WgLhZxcAXSh2qPdLt
         hK48tVVdLeBtaRVi6e+UgN9CWl4l0lKUgy5cw0moHIFBNkHGr2RA0wAqn/Q7BXL26AlG
         m7ofweP3qu3ZGZaxqxhvKU/74mOnmxd4+MPw3EQ5QiWXevP0fiN1efgUSCd6MMVWhiF7
         wPPA==
X-Gm-Message-State: AOAM530oCm4r7e2ussvjZmIatWb1DpULkK0edvfs/myddRM3nsfh1K3f
        qtdmWqKJYPRljWgwjd3Y4YqTZslsb79eGW+XzY2U/18R3pGnW81v++u+7wpYe4W2QsT6/LWdU/6
        lcqJQX/qBlLGzFZwsAcgs79Uv
X-Received: by 2002:a1c:5444:0:b0:39c:3761:ac37 with SMTP id p4-20020a1c5444000000b0039c3761ac37mr943461wmi.144.1654884242952;
        Fri, 10 Jun 2022 11:04:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKlTK8/3tGwSukWS1t2M37Kp0CZ0Kvfx/vbiurZ+tsKe1uz2FzmudIzWkwYCQatu+kCzj7aA==
X-Received: by 2002:a1c:5444:0:b0:39c:3761:ac37 with SMTP id p4-20020a1c5444000000b0039c3761ac37mr943440wmi.144.1654884242685;
        Fri, 10 Jun 2022 11:04:02 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id u2-20020a056000038200b0020ff3a2a925sm68257wrf.63.2022.06.10.11.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 11:04:02 -0700 (PDT)
Date:   Fri, 10 Jun 2022 20:03:59 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 142/144] KVM: selftests: Add kvm_has_cap() to provide
 syntactic sugar
Message-ID: <20220610180359.sx3yiunvpu56stm5@gator>
References: <20220603004331.1523888-1-seanjc@google.com>
 <20220603004331.1523888-143-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603004331.1523888-143-seanjc@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:43:29AM +0000, Sean Christopherson wrote:
...
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 8f7ee9cb551c..12b7c40542df 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -80,7 +80,7 @@ unsigned int kvm_check_cap(long cap)
>  
>  	close(kvm_fd);
>  
> -	return ret;
> +	return (unsigned int)ret;
>  }

This belongs in the last patch.

Thanks,
drew

