Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AA4566F8D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiGENl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiGENl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FAD49FF8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657026203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcqc3K8hLnun9J+aaNxY7kmrwVy/CGHdbZEFAaqD4wE=;
        b=aplzgoirjFSSfuFZZld+XSkkDqMiLZKP4SRyz5XF0ZQyjEmzdKI9PhKqT+E3C0XJGA6gEL
        /1S8nPiH8wAZwhMOYQZJbNsQCgrK+qyiqkW10v6cHMimZsx6jLSv9MoVJS6KOdvvKUEFC2
        teGtFBodQ++IkdJxp+GS/mWY5D8cLJ4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-avBPvpKMOWGJvndDEn1_EQ-1; Tue, 05 Jul 2022 09:03:22 -0400
X-MC-Unique: avBPvpKMOWGJvndDEn1_EQ-1
Received: by mail-qk1-f198.google.com with SMTP id bp10-20020a05620a458a00b006b265587a17so9574727qkb.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 06:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gcqc3K8hLnun9J+aaNxY7kmrwVy/CGHdbZEFAaqD4wE=;
        b=soHRhxXuwQKi1/lg4IqFL3QyPMQO4gy9Ervn1EtrIjYUi2HFtRLaBwRVt5lAqbyxG1
         YSL72JysuXW+eXipvysZUSkVLRmGyfA7FnhjcjNl3OLQQPDtwXuZ8RCChWmh2RZ5EVaG
         njr/uwAcPU+MJ0Ck00TsadbSWlVB/frtIiojq96+KMufKB2qfE2ybgBkLB42/uF5yhDP
         k9TrjJezfjfWMTi37mqOcTPkcbgJ4O8+AttZpIXKA5h4BM1vqrcAGMZvQ6YB8ojJtCvE
         /XsC4XW72N4WhQdASXbFRi3SIad+QbNmHbU0UuKMs0zrIr4JLFCKHudcza0Rh8YmIHhb
         6hOA==
X-Gm-Message-State: AJIora/ONlamob+Aw49IeIHZA1rSUisGRv6180+gt/DeJj1jQTjhgyps
        YCCdv1ljD8iLPP4lBnHfJx5Tw77YyZYbyaPuA+gfsUWy4/JOg97z5XfH6VBFtio2yqH/83F/FEM
        S2A5MtQcovhnThgTdid0Jn+Vr
X-Received: by 2002:ae9:e887:0:b0:6af:5378:41bf with SMTP id a129-20020ae9e887000000b006af537841bfmr23180531qkg.673.1657026201777;
        Tue, 05 Jul 2022 06:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uul3n5kLo34SI8tCFakypuYVTzBRILG1vIei8jwMwdm0l/l2kb6Bx8d3RkctQdYVCTyAqU8g==
X-Received: by 2002:ae9:e887:0:b0:6af:5378:41bf with SMTP id a129-20020ae9e887000000b006af537841bfmr23180493qkg.673.1657026201451;
        Tue, 05 Jul 2022 06:03:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a76a939dbasm27403050qko.112.2022.07.05.06.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:03:21 -0700 (PDT)
Message-ID: <2eefbb3d5190a2fb24ae075725166ceb2effb433.camel@redhat.com>
Subject: Re: [PATCH] net: macsec: fix potential resource leak in
 macsec_add_rxsa() and macsec_add_txsa()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jianglei Nie <niejianglei2021@163.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 05 Jul 2022 15:03:18 +0200
In-Reply-To: <20220704123304.2239147-1-niejianglei2021@163.com>
References: <20220704123304.2239147-1-niejianglei2021@163.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 2022-07-04 at 20:33 +0800, Jianglei Nie wrote:
> init_rx_sa() allocates relevant resource for rx_sa->stats and rx_sa->
> key.tfm with alloc_percpu() and macsec_alloc_tfm(). When some error
> occurs after init_rx_sa() is called in macsec_add_rxsa(), the function
> released rx_sa with kfree() without releasing rx_sa->stats and rx_sa->
> key.tfm, which will lead to a resource leak.
> 
> We should call macsec_rxsa_put() instead of kfree() to decrease the ref
> count of rx_sa and release the relevant resource if the refcount is 0.
> The same bug exists in macsec_add_txsa() for tx_sa as well. This patch
> fixes the above two bugs.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>

The patch LGTM. This looks like -net material, so please repost
specifying the correct tree into the patch subj and more importantnly
including a suitable 'Fixes' tag into the commit message.

Thanks!

Paolo

