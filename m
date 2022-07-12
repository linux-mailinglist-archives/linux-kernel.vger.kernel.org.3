Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD109571ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiGLNGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiGLNGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B826DB41BB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657631190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/CeT2ojjQEER/enNmFp+mqLwealH1XntHPCyccrO8c=;
        b=W1kY0HxMBSrbBjyMuCvlK88ZI+SZ6qG8aUEbAYjYAV0wMo6vmg9KXAV4hRaTrWowB+sC36
        4PDzgdd2ra0jMKvpdgZYYAkRI3JxXPdwMJYisfGncwUqHDjK+b8QT/IHrc1SLnDrwwEGvW
        LNT6m6YFak7g1QhA0Oy3fEDPlqrKvAY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-YZ7d0jlZOS-L7lUigkxS6A-1; Tue, 12 Jul 2022 09:06:29 -0400
X-MC-Unique: YZ7d0jlZOS-L7lUigkxS6A-1
Received: by mail-wm1-f71.google.com with SMTP id r206-20020a1c44d7000000b003a2cfab0839so3776572wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5/CeT2ojjQEER/enNmFp+mqLwealH1XntHPCyccrO8c=;
        b=dKEEJzLAsKfDzSrL90BZONYuyZcL4AT0glVDez1jngsVDAdIfmQvu4WkvNJwVQoyQt
         S5MO4kzIwWo1iM2JN+pyVfFrF1zhp4UEAyIXg9BuXZsFltF0rSIYjMmplE2DBV/oLMOc
         pA5+3OvNCmtN+HM0N4H5abhi2zTW5B2DM/Wz5sYgMtBMNuP8rHXLq7jufhg0vmW6G2oq
         z3xGtn6mQEz2DJ4EryAzRrBC95xZ2/mhf2DQouYFfqjxMXy+GqwPda+eaNT39GcWoB1I
         KcdsaOyO7SQFweJB02vM4JPkrnEFRvpIC6OX5ba4FAGegBbZf7z1nCT6sMHiuIJzOLb5
         19Og==
X-Gm-Message-State: AJIora+2evn7wbma+0Xph8QZ/6xqOiYdluEf8t4nUKMfL1jHbQCYJQ41
        3JfKCah4uVUsFX74iybWM6qu5uyVCUcGLBz6FaeYYSEmrs7u+S8FOyvGR8BPjwZHNV+laIoYiLC
        1b1m1xVLy6U/bsKmfE+xUK8Ly
X-Received: by 2002:a05:6000:1282:b0:21d:6afa:35ca with SMTP id f2-20020a056000128200b0021d6afa35camr22092022wrx.452.1657631187523;
        Tue, 12 Jul 2022 06:06:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tBspQk4B0/EnMPbtKuqFZnqeT0SFrU/OxTovC2mES5+VJIPNhM4CSqY2uXl/P+dh5+ioy2yQ==
X-Received: by 2002:a05:6000:1282:b0:21d:6afa:35ca with SMTP id f2-20020a056000128200b0021d6afa35camr22091986wrx.452.1657631187137;
        Tue, 12 Jul 2022 06:06:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-238.dyn.eolo.it. [146.241.97.238])
        by smtp.gmail.com with ESMTPSA id c187-20020a1c35c4000000b0039aef592ca0sm9539911wma.35.2022.07.12.06.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:06:26 -0700 (PDT)
Message-ID: <e3745b77b8537e08bbace5088d9f41e21755e08b.camel@redhat.com>
Subject: Re: [PATCH net] r8152: fix accessing unset transport header
From:   Paolo Abeni <pabeni@redhat.com>
To:     Hayes Wang <hayeswang@realtek.com>, kuba@kernel.org,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 15:06:25 +0200
In-Reply-To: <20220711070004.28010-389-nic_swsd@realtek.com>
References: <20220711070004.28010-389-nic_swsd@realtek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-11 at 15:00 +0800, Hayes Wang wrote:
> A warning is triggered by commit 66e4c8d95008 ("net: warn if transport
> header was not set"). The warning is harmless, because the value from
> skb_transport_offset() is only used for skb_is_gso() is true or the
> skb->ip_summed is equal to CHECKSUM_PARTIAL.
> 
> Signed-off-by: Hayes Wang <hayeswang@realtek.com>

If this is targeting the -net tree please add a suitable Fixes tag,
thanks!

Paolo

