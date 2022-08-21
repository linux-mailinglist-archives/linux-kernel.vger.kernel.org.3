Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE4E59B4E5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiHUPMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHUPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:12:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F305FB5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:12:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gi31so10434559ejc.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZaWtw9Zg1nD5CoL5cE2PY2gb33V2/yQXN/4KLffNp9M=;
        b=e2DTWR3YpfOjEHiMva39dkePzbaqOOjoCOG4mZEeHn5GGuOwWvgxfgeqwo7RP5BrmM
         YTRwjNG4MLbmPQKeiXLh/KoS1wrGEeAPv9xqDGuufErHU5+YEe3LsRGCbqNibKxcI9WI
         Mfc/TDTI2DsLAJWIFmDYZiZ3HApIDBauVWgnX5zotQPg/OfZjNNJm6+IZTRJs7jSAtlO
         t39gM2a6NlA/9GUNgxE6WBKmiRhIbVFzyEesoZ/1+19cDT5gSGN4SgVO+q18uCYIG67+
         qeFYod72WbkE0k8TJjryAuiTQhEgniImrKh5GyeSoFBo3YkYqza9mq6AZkItTTXrQVkI
         v4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZaWtw9Zg1nD5CoL5cE2PY2gb33V2/yQXN/4KLffNp9M=;
        b=0T8tRmtwTVAwNXK1a5pfivhYcaiPOVJ4NZOwib1ymxF+n9PA0WShQNiBElL3roELah
         6AgAYm28C2OKa1CYgdnssHavUd0cNgz0i/Dp/bhRVzPxmoEyLmGaSL0LYTEluMv8dEOE
         Udu6muz9YKx5Noi6vaki0Z1pZfGkFPgfykbcVxBlHgY+v/Rs5jV6oCmfHuwT1bWDzaWy
         KXTGFILF7BP8R3yAyUSyQWiYUk0mB4EULt9QRw2wxs2vf5fzUH5hZvGRMkwfT8gRInJ9
         Tif6tOMMu7QFQOaNsldZ8wnV2jQG8sjR/ISWD3MC/gy9tjAK/NJGO1Bu6Hp0EtzTWqSz
         WynA==
X-Gm-Message-State: ACgBeo0H1aM3K6GINhKey4X9VyV5t/MAkzaF/W0gdnfzvl9q/wsT/pLb
        e+FBPMxSwR2G8QJUnbzjyaI=
X-Google-Smtp-Source: AA6agR68YNxfCRPYknc8+Ny6gQI1mqxcOIR7ZNTAXkL+VYPiJcMo2uyQ2HewLVkw0Q9bUKOXtYQTgA==
X-Received: by 2002:a17:907:7256:b0:730:f074:963c with SMTP id ds22-20020a170907725600b00730f074963cmr10782622ejc.201.1661094724854;
        Sun, 21 Aug 2022 08:12:04 -0700 (PDT)
Received: from opensuse.localnet (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id bm16-20020a170906c05000b00730a1c73288sm4962663ejb.49.2022.08.21.08.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 08:12:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date:   Sun, 21 Aug 2022 17:12:00 +0200
Message-ID: <2113668.irdbgypaU6@opensuse>
In-Reply-To: <8f3e0127-91d4-af1f-ba41-951e2c5050f9@nvidia.com>
References: <20220817184519.25141-1-fmdefrancesco@gmail.com> <8f3e0127-91d4-af1f-ba41-951e2c5050f9@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=C3=AC 18 agosto 2022 17:48:04 CEST Chaitanya Kulkarni wrote:
> > -	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
> > -		cmd->nr_mapped, cmd->pdu_len);
> > +	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov, nr_mapped,
> > cmd->pdu_len);
>=20
> >   }
> >  =20
>=20
>=20
> overly long lines above ? we are keeping lines < 80 for consistency, can
> be done at the time of applying patch.
>=20
> -ck
>=20

I'm sorry for this.
I changed my post commit hook and forgot to make it executable :-(
I just wrote to Sagi and said that I'm going to send a new version with the=
=20
results of blktests. In the meantime I'll shorten those long lines below th=
e=20
80 characters threshold.

Thanks,

=46abio=20


