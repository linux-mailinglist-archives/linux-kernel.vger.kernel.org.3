Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EB8594E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 04:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiHPCQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 22:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbiHPCPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 22:15:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEFB248DB9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:24:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i14so15806864ejg.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/3IXWzd+wl2RRDXeLv2+xA05vlC4U88YqM5/n+NeSEQ=;
        b=K3GMgspDwTktDa13IofgOH0wIJzbay3VW81an1jha0AKmOvhDPlvRk0WOZp6aDvlbD
         6//WGvjCK/LH0DzeGdavGl9SU1jN+Muei6YeSDdFyN+n9WLwulVhMtFPW9uH7+1wRBge
         tPfBSs5ZiDfdB4kY4wPKlDhGDIY+DTVDjQvf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/3IXWzd+wl2RRDXeLv2+xA05vlC4U88YqM5/n+NeSEQ=;
        b=ISF0mQjcNzAR4cleCWSJIKcJOFVs/OGhn9ZvF3Qc82g93OKK+wqkbIlbhiWdtDX6gt
         MY3sPFVc+076B7fy95el9MFwd72BAZZzAeKmIQY42m7YKIIX81ueZ6bIjlmtfMmdpD/g
         dYFZ9ph6ZS7IF7iuXzvFMeIE7HAPqeIAfmIMl8IfPekh73Xwojq815WNbfoYQeC7UXWU
         t2iDoXiayMKG625OHKmnsKDEsIavygKW1h5i9fDx5DG39RG/QCiYL30088ROB+iebURv
         h6Crz8IuE+UK60Hwmnf3ZjSgG2hHX4rNroTPBOrVJbUASYyowxyW9e9/zYQ1TNLjOxNb
         RBKQ==
X-Gm-Message-State: ACgBeo3KInXpJgz7w3WUDDXGnAE8cInEPITFMWDUibe4Ps5uSXV7AeHu
        qhX02EyP/g0GHMSC1R5WFXIMd/lWYuoAsAdl
X-Google-Smtp-Source: AA6agR7I7qIQh/qAOv9xbn7uTTFLie7zggfrjjqeu3QX2gORLLcFCktSHX2ySF4SgmT3NE5pf1KWhg==
X-Received: by 2002:a17:907:7b95:b0:72f:9c64:4061 with SMTP id ne21-20020a1709077b9500b0072f9c644061mr11542999ejc.351.1660602286356;
        Mon, 15 Aug 2022 15:24:46 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id bt2-20020a0564020a4200b0043d1eff72b3sm7401959edb.74.2022.08.15.15.24.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 15:24:45 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id j1so10580140wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:24:45 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr9331179wri.442.1660602284992; Mon, 15
 Aug 2022 15:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220815215938.154999-1-mst@redhat.com>
In-Reply-To: <20220815215938.154999-1-mst@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Aug 2022 15:24:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=Ju_jhbww7WmpgmHHebMSdd1U5WBjh925yLB_F1j9Ng@mail.gmail.com>
Message-ID: <CAHk-=wj=Ju_jhbww7WmpgmHHebMSdd1U5WBjh925yLB_F1j9Ng@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] virtio: drop sizing vqs during init
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> But the benefit is unclear in any case, so let's revert for now.

Should I take this patch series directly, or will you be sending a
pull request (preferred)?

             Linus
