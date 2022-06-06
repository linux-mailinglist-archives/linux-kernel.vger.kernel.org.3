Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DA553E373
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiFFIKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiFFIKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C425E6B081
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 01:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654503007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obCrGJypUtMnd9bI3/liPqkSW10QMUPaG2j9LH/B4lY=;
        b=ga4fuBQtuqzNAL7usWqlC0NePSp8eZxobUXPK8ouzJcrKLeQJZFKf/fPDAtiBK5e3TcuVN
        Afd5+E5vT39Al57r9ptr0R6SP0HxTsvjuEO4/HZhLlUUDChS37ET7q0O2/+TR9RAlMzz9a
        WKwfRFbKi+4xds6mrlpvjHzf6l8XCZo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-aHgsapA_MdyNA1rCaNIVRw-1; Mon, 06 Jun 2022 04:10:05 -0400
X-MC-Unique: aHgsapA_MdyNA1rCaNIVRw-1
Received: by mail-wr1-f72.google.com with SMTP id h2-20020adfe982000000b002102da95c71so2532528wrm.23
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 01:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=obCrGJypUtMnd9bI3/liPqkSW10QMUPaG2j9LH/B4lY=;
        b=Cpvxk3PXs1+cX9nloKc4HLvcBmeni2jqHcDWxPU2drYfqEreW4U/MusxXmUDBzjX8D
         WTPaCRK/vmdicqXD3MYqYe9VVJwAceVb0oSsJg6uR5pVW4HSk19hI4J60gj+x1qen5+k
         StypTCmRgtrBkPwaQEwpNK2vUZZ0zU6X97HE2sX4reXWMwFagYXVFk0bg66n4G7po6c+
         ocag+elrnAq6EVAZIqdYCMXyQiReCgCcQ8YOxjdBevxDa1OdZU8nwX89iJmbu8Y8v1Dj
         rFQONZycq6XPICdwPG4QgwXify52p0hLiL8s1JYgSQGGAtKIgnV0HhHSVqgbDwBTxGsW
         swHA==
X-Gm-Message-State: AOAM533ftaHmDDzFrjPxqRfVGT7YY9UCwD9pUHJx6J9760EFdj1H+HK/
        f7wtvTF8pN3Q5EgOa/deCsQcwEdCSWiwznvkV2fHaz7nlf3/I9N2q5HrNDBokr4dDfsc5CtPChX
        L6v+n6iF6xW5Q4yQa2s86EwTo
X-Received: by 2002:a1c:ed0e:0:b0:397:2c71:c476 with SMTP id l14-20020a1ced0e000000b003972c71c476mr21767854wmh.113.1654503003889;
        Mon, 06 Jun 2022 01:10:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOSVcOJDSge59HfwBAndkDw0Jz/viRLPlqzKLuh8E/9wwQHp1Tppl7/PVanwk/HLtyNRVz2Q==
X-Received: by 2002:a1c:ed0e:0:b0:397:2c71:c476 with SMTP id l14-20020a1ced0e000000b003972c71c476mr21767836wmh.113.1654503003629;
        Mon, 06 Jun 2022 01:10:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id k7-20020a5d6d47000000b0020e5e906e47sm14399752wri.75.2022.06.06.01.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 01:10:03 -0700 (PDT)
Message-ID: <33aae30b17a14b41212f9c3ed0f8943817a835d9.camel@redhat.com>
Subject: Re: [PATCH 2/2] l2tp: fix possible use-after-free
From:   Paolo Abeni <pabeni@redhat.com>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.or,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Jun 2022 10:10:01 +0200
In-Reply-To: <20220605115412.16004-1-ruc_zhangxiaohui@163.com>
References: <20220605115412.16004-1-ruc_zhangxiaohui@163.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 2022-06-05 at 19:54 +0800, Xiaohui Zhang wrote:
> From: xiaohuizhang98 <ruc_zhangxiaohui@163.com>
> 
> We detected a suspected bug with our code clone detection tool.
> 
> Similar to the handling of l2tp_tunnel_get in commit a622b40035d1
> ("l2ip: fix possible use-after-free"), we thought a patch might
> be needed here as well.
> 
> Before taking a refcount on a rcu protected structure,
> we need to make sure the refcount is not zero.
> 
> Signed-off-by: xiaohuizhang98 <ruc_zhangxiaohui@163.com>

It looks like series this did not make to patchwork, due to a typo in
the ML address, please fix it and resend: netdev@vger.kernel.or ->
netdev@vger.kernel.org

Thanks,

Paolo

