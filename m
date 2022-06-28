Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F9155CA38
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242932AbiF1HrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiF1HrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05637C7D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656402434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhwYJTHCpA5f1vgUVZ/tbiw7F2pML5jzftZeJbrY+xY=;
        b=cQkM0Okv11DboQzF+x3NQ2tLxuq0O6CunJ4/c4ua0jq9L4TV2rgCXwCjUpS2+e39UsF/n1
        lnTdR70e0hwM5Dn3EJChhZ5ySPnQd9pyob3bG4qVb55/2pHY8reMDrXdsiQYgBEm5TYMAN
        OE+RWvszfx67s0DXhKh7G6vepUBmEQ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-NltKiXYYNSSEBi-S8J2KAw-1; Tue, 28 Jun 2022 03:47:11 -0400
X-MC-Unique: NltKiXYYNSSEBi-S8J2KAw-1
Received: by mail-wr1-f69.google.com with SMTP id o1-20020adfba01000000b0021b90bd28d2so1564518wrg.14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vhwYJTHCpA5f1vgUVZ/tbiw7F2pML5jzftZeJbrY+xY=;
        b=QZp0dJN+PXXAweNna0dARvf1GqFegTJyuJdSeYkgJST6OTzjWTuYf77nesvBokzyWe
         PDPNbxC/xfe+nzLfsNd8FePD/gUOPLYp23Tj3PITkVvlaY8pjWQhfKsNRDAJGIe62DOg
         BKgd0bMWLZx/s1uH+eFOZkyQlfrzdoR2zz3gOmC78Haf2glmEpaXCnoxpy4M1BTPVD6W
         PWAmq/Me148fkKO2dLdAXwaTDOpPKC3SYFishGgq6uZm8tGoqVC+CNrtoribazbOFoeb
         maVOs5ITmBnHzCp/aTAz4WgSSK7H/ebLEqsGqak0hL5E3aCwzz6velIF3L4ffO1Ecelr
         kDog==
X-Gm-Message-State: AJIora8ymBgwLBTMVsezBmNj9JLREgyfiCvSujggzrEP7bQY9bK+yR7s
        H/u62Ukr3gSa4PYlfb7yXFQW3JvnHjmF7KRLHMpTYN5nXKhMZFUaFt/FJY++xe/OUEjuULf7Hxk
        4t47u0JT1Z5x8UbPOAiLoR+k=
X-Received: by 2002:a05:600c:4f13:b0:39d:b6c5:ce4e with SMTP id l19-20020a05600c4f1300b0039db6c5ce4emr25402396wmq.34.1656402429978;
        Tue, 28 Jun 2022 00:47:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vtS3T9UbI6Ib3KtZ+peaUDKLlP6cSEmfzlOgUCOkeKGlpETh+pHg15t7TzPLRS39uNiiA5oA==
X-Received: by 2002:a05:600c:4f13:b0:39d:b6c5:ce4e with SMTP id l19-20020a05600c4f1300b0039db6c5ce4emr25402380wmq.34.1656402429815;
        Tue, 28 Jun 2022 00:47:09 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id i1-20020adffc01000000b0021b5861eaf7sm13057958wrr.3.2022.06.28.00.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 00:47:08 -0700 (PDT)
Date:   Tue, 28 Jun 2022 08:47:08 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] module: Show the last unloaded module's taint flag(s)
Message-ID: <20220628074708.fg3ocx3vu7affkxl@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220627164052.2416485-1-atomlin@redhat.com>
 <20220627164052.2416485-2-atomlin@redhat.com>
 <4ddb64da-58f0-a4af-cf57-a870015a0077@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ddb64da-58f0-a4af-cf57-a870015a0077@csgroup.eu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-06-28 05:54 +0000, Christophe Leroy wrote:
> > -	/* Store the name of the last unloaded module for diagnostic purposes */
> >   	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
> > +	strcat(last_unloaded_module, module_flags(mod, buf, false));
> 
> You replace a bounded string copy by an unbounded strict contat.
> 
> Should you use strlcat() instead ?

Hi Christophe,

Why? If I understand correctly, both the destination and source string are
NULL-terminated (see module_flags()). So, strcat() should be sufficient.


Kind regards,

-- 
Aaron Tomlin

