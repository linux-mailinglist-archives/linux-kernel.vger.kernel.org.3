Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046F258C85A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242866AbiHHM2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242230AbiHHM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0439DEAD
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659961677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l68EjihpMW1PjKtRUpt7ucyYQUG0wGAM29WL8EddQq4=;
        b=g8zlxsIXxu/0KdJnn8vmoXhu6bJOBfUaoU63D2gMQO1yYzTbaU3CKkiG6kl4u2k27/wOvc
        7JeNjIdvUakpmUK80S5lq6+Cn9ptA0ivxRbOmWgzmNmBp9W2UP5k7SQZstLLOcmS7MmP9Y
        8kYU1zJBJUFMKn/eTjmQtlRVyTxEWdk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-w1NskctGN_icpIezNT267Q-1; Mon, 08 Aug 2022 08:27:55 -0400
X-MC-Unique: w1NskctGN_icpIezNT267Q-1
Received: by mail-wm1-f72.google.com with SMTP id i65-20020a1c3b44000000b003a537031613so313844wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l68EjihpMW1PjKtRUpt7ucyYQUG0wGAM29WL8EddQq4=;
        b=25gYgV6QNHkqaudA9DaZxtDCoY47rgfD/CCBgF8b51NhCtLeYIhLusZfWxNFbTrMFb
         v5DVs8JIm6Ji3zNEt0U4vx21svPBEuk+FlDAjM86IxPk+YO+JJzmfJNnXeiWG3ACPY8X
         ktiobuw8mHD65wfYDGX/Vxxq5hH9skcCIF9NaIA0ZjTBi/+M/nXpt4Z8njjfoV+3tOIx
         DIHO0YAlGKVbYels12dNFaKPfkUsnPTAOtfSS+fmVkW6iwYEHkHNrhsTHxoJIPmMIkDv
         3CCEUSwDorwif17Hv4yKA4/70895IYH1X34lrSNr5DtYx9jZywm0Iq/lPg8qSLElwNWe
         sc9A==
X-Gm-Message-State: ACgBeo2ffGEGH4xLZOhiVkT9v2iSs5Yb3qTBxx//Oh2ITG0/+W2ZHA6R
        FjC56L6GiTeSmtq25OY1dacWfNehsQjT8IgfxHc0ptfe1+5hlDBZC4qWiGXWpd4bKuc4MNy5sjd
        ZOBUJTEc+IhNpDfrD0H6JPn+C
X-Received: by 2002:adf:ce81:0:b0:220:6245:9cc6 with SMTP id r1-20020adfce81000000b0022062459cc6mr10991933wrn.402.1659961674709;
        Mon, 08 Aug 2022 05:27:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7zKuxil7V7H1JSg2mNNZaPgFdQ6qdjUdoRQloVdd7JNpK8sa4fHUFNDDleC7+bMnpIbqjsBg==
X-Received: by 2002:adf:ce81:0:b0:220:6245:9cc6 with SMTP id r1-20020adfce81000000b0022062459cc6mr10991923wrn.402.1659961674500;
        Mon, 08 Aug 2022 05:27:54 -0700 (PDT)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bce08000000b003a4f29d6f69sm20893630wmc.36.2022.08.08.05.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:27:53 -0700 (PDT)
Date:   Mon, 8 Aug 2022 14:27:51 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Matthias May <matthias.may@westermo.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, nicolas.dichtel@6wind.com,
        eyal.birger@gmail.com, linux-kernel@vger.kernel.org,
        jesse@nicira.com, pshelar@nicira.com, tgraf@suug.ch
Subject: Re: [PATCH v4 net] geneve: fix TOS inheriting for ipv4
Message-ID: <20220808122751.GB9123@pc-4.home>
References: <20220805190006.8078-1-matthias.may@westermo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805190006.8078-1-matthias.may@westermo.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 09:00:06PM +0200, Matthias May wrote:
> The current code retrieves the TOS field after the lookup
> on the ipv4 routing table. The routing process currently
> only allows routing based on the original 3 TOS bits, and
> not on the full 6 DSCP bits.
> As a result the retrieved TOS is cut to the 3 bits.
> However for inheriting purposes the full 6 bits should be used.
> 
> Extract the full 6 bits before the route lookup and use
> that instead of the cut off 3 TOS bits.

Acked-by: Guillaume Nault <gnault@redhat.com>

