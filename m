Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7100A5A7B36
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiHaKTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiHaKTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34586A4B3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661941153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZpRLTT1itQwP+u94Lmsh32laOgKQktQ3e6PuJ0p2Rms=;
        b=MuhZkU06+xUSv9DphfBsNeGsfikovkqjkeG+cJ2XYxejVWD6fvY4JzGLtduKDgsU7mef9O
        ZW9SSCe4jJtcMJrllSe8lBl/13hldtlR6f7dwrNiJ7AUqTLnv9dCBy76xuA0vKNxCB2ZEe
        hXXeIfVQ8k9Dcn7xZlGB0F1Njyg5ogg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-GkGOpxvoPhOJksLMWjSDkA-1; Wed, 31 Aug 2022 06:19:11 -0400
X-MC-Unique: GkGOpxvoPhOJksLMWjSDkA-1
Received: by mail-wm1-f72.google.com with SMTP id f18-20020a05600c4e9200b003a5f81299caso8086249wmq.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ZpRLTT1itQwP+u94Lmsh32laOgKQktQ3e6PuJ0p2Rms=;
        b=tyvIUGHecqQTxhfJ2pATFzBKEIpJad6CnRJxGUaSiFvRyxWugPSsqL/R+v5JpzNdJb
         oV5BN72XisJ30EjAVn+Y6wta/Xan10DcTaGhZLgzKxi3ks9onNPXwmCQ3XcpEFQM7udw
         0hlBmzhCnU/3rxtxuUFw+xZvwad5deUMsTR4IxDFDuouCuqrCzupmLuiuH1rJ0kMsAG+
         G1xU7IZx2DFzWecawNYfj7YcCIWzC1XIHXcrri0b9orTJ+U9DzVKao+uIqI24uRRiuX3
         oQT6Euq4kQ/73QCbBZF6eWooOw+n7eFkEcEi68RoTfLMw1yXlz0uEFRfcfYxcux6mQT0
         nyrg==
X-Gm-Message-State: ACgBeo2BqJKhrhIz+rYoCZZRYs91ypb57L/evT3MXOiPGX9RVjUUiU6o
        Qreekku+dKmoH9/YkCMImeQB1NyH+J++i16EWrjmLbHOBBTKPf4UnVkRcl4RYlDy8cDCJ9y4Kh6
        Wqyk++WCvlnVz24J1o8OM0po=
X-Received: by 2002:a7b:c5c3:0:b0:3a6:14f3:8ea7 with SMTP id n3-20020a7bc5c3000000b003a614f38ea7mr1465433wmk.76.1661941149694;
        Wed, 31 Aug 2022 03:19:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7PA9SH0oxj5GA6arasN/HeWr1ySDu7wDrfw96TfFaP41YwtAWjTM8Fq70mv1aAeWH9rphx4g==
X-Received: by 2002:a7b:c5c3:0:b0:3a6:14f3:8ea7 with SMTP id n3-20020a7bc5c3000000b003a614f38ea7mr1465421wmk.76.1661941149506;
        Wed, 31 Aug 2022 03:19:09 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id e14-20020adfef0e000000b0021d6924b777sm7186178wro.115.2022.08.31.03.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 03:19:08 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:19:07 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com
Subject: Re: [PATCH modules-next] module: Add debugfs interface to view
 unloaded tainted modules
Message-ID: <20220831101907.5rqz6ylj2dyojqnj@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220823193225.2072649-1-atomlin@redhat.com>
 <2bf2b4ee-fd8d-962d-0daa-9c8093ad331e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bf2b4ee-fd8d-962d-0daa-9c8093ad331e@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-08-29 09:14 +0200, Petr Pavlu wrote:
> On 8/23/22 21:32, Aaron Tomlin wrote:
> > [...]
> > @@ -59,3 +60,68 @@ void print_unloaded_tainted_modules(void)
> >  		}
> >  	}
> >  }
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +static void *unloaded_tainted_modules_seq_start(struct seq_file *m, loff_t *pos)
> > +{
> > +	mutex_lock(&module_mutex);
> > +	return seq_list_start_rcu(&unloaded_tainted_modules, *pos);
> > +}

Hi Petr,

> unloaded_tainted_modules looks to be a proper RCU list which makes me think
> this reader could use just rcu_read_lock() instead of
> mutex_lock(&module_mutex)?

If I understand correctly, yes: the use of rcu_read_lock() and
rcu_read_unlock(), respectively, will be sufficient.

I will send a follow up patch.


Kind regards,

-- 
Aaron Tomlin

