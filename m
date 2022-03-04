Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F6A4CD85E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbiCDP4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiCDPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:55:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D46D1C57F7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646409310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uch525PNzzW/J3vJE1xnSUNTO3TZySaL5iNLrnWYiN8=;
        b=gVtSI+KuVbS2BNvREDoQwo+1IHutc+03r6dFogqBC4IcxxhFr5XsKkU1ssy7Se8QewThzw
        CoUAxwPy0QflQ939Gr6I5baEegLs5GcXjXtb1nCFJD7K2VFZGW1zYubiGL7qiTs+8+ylwL
        r5QIOOPWSGNd0Go4Le5rKDFxJQgGrc4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-m-Dg4_WZPAqXYX8TI4jajA-1; Fri, 04 Mar 2022 10:55:09 -0500
X-MC-Unique: m-Dg4_WZPAqXYX8TI4jajA-1
Received: by mail-wm1-f69.google.com with SMTP id v67-20020a1cac46000000b00383e71bb26fso2442515wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 07:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Uch525PNzzW/J3vJE1xnSUNTO3TZySaL5iNLrnWYiN8=;
        b=D/s8tEPobD/RDu4zGuIAD8QcgD7fEGG29g/eG+GkmCEbYLJt2l6v+32mGv/aY50F2d
         XVDIU8yL0Zb0KHY5/gOk0ambXvc8fEvEH9Tln0ZWqrePaHbOeSzuWzjyL0R7fG2ynl51
         WR2oEGARkfclq3HbI+ICWTKRkkvMO5gNuOZ5nBurjaS9WyPk6ZihHldje63X+JFaipNO
         FDyLgWPH7Uk41hofI2fsE3RopozBF3j7258VeLrRuuGdXeJcX8A0AbM0ooBlHukHOBkS
         GVw5FQhORBJ8L0UoLUbmOiRCACIVkV4mMECAn1ikSEOTtELwrTMda3PfXfRydXix+Svo
         E1rw==
X-Gm-Message-State: AOAM530E/apdvi3wq6E/FS0bnKg/sqQR+9X+dvIaqE6XlOHqkrmVbW5B
        da9xPdgWYQ6UmFXKZ0nNYFvB8SQW+hP+HDnUDVwOQnMrctF0cRHhH6tnNRGp+uwz99SDF7iXzLw
        Vng1rj7dD8VgxMhsjp9Apx/Xn
X-Received: by 2002:a5d:6852:0:b0:1f0:98e7:a963 with SMTP id o18-20020a5d6852000000b001f098e7a963mr2244689wrw.646.1646409307762;
        Fri, 04 Mar 2022 07:55:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJcGPsQgyi0xlwPiC3QwSn+wMpjkPFk3GJKUBiMtrkUOc3OvwgWUVHrxOyndsunz6WuZ3MEQ==
X-Received: by 2002:a5d:6852:0:b0:1f0:98e7:a963 with SMTP id o18-20020a5d6852000000b001f098e7a963mr2244667wrw.646.1646409307612;
        Fri, 04 Mar 2022 07:55:07 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8? ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c1d1000b003816edb5711sm12563176wms.26.2022.03.04.07.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 07:55:07 -0800 (PST)
Message-ID: <34833549a995fa3325f4ceb9b42cd01de0921c14.camel@redhat.com>
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, paulmck@kernel.org, rostedt@goodmis.org,
        Juri Lelli <juri.lelli@redhat.com>
Date:   Fri, 04 Mar 2022 16:55:06 +0100
In-Reply-To: <bc048c18-0ba7-1cb9-90a0-0bc049997c23@kernel.org>
References: <20220228141423.259691-1-nsaenzju@redhat.com>
         <78d798aa-388c-70bc-4227-985ba76c1d7e@kernel.org>
         <b5e1f0d14a48c0815863af623cedbdc8c1bc255f.camel@redhat.com>
         <abb789c3-0d1a-28e9-3b8d-e4a68e3f57f5@kernel.org>
         <2b47679c6248a0d113b556ed6118e8ed72c74b29.camel@redhat.com>
         <bc048c18-0ba7-1cb9-90a0-0bc049997c23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-04 at 16:37 +0100, Daniel Bristot de Oliveira wrote:
> On 3/4/22 16:28, Nicolas Saenz Julienne wrote:
> > Some comments:
> >  - You're not exiting/entering EQS on IRQ/NMI entry/exit. See
> >    irqentry_{enter,exit}() and irqentry_nmi_{enter,exit}().
> 
> hummm, right!
> 
> >  - See this series[1], if we ever pursue this approach, it's important we got
> >    through context tracking, instead of poking at RCU directly.
> 
> I had a test patch with context_tracking as well... entering and leaving using
> it. Lemme find it.... but it basically works in the same way as for RCU (or
> pretend to work).

Yes, agree, it's fundamentally the same.

-- 
Nicolás Sáenz

