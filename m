Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4069056571A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiGDN1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiGDN0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:26:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5CF012773
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656941021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++fJgtu1Gsy4nJVDDaNos/TBbdlOhBzdbNWHZ5EkqwY=;
        b=BOkXi0UN+JdRgN032nBhIKmB2oaUzOytPqptCFcaSVM649wSYLMp53uXLiGi83SpCjAWfK
        pRN0/NnaE/UPgFeEccDELgY/mibl135+pl124kr4mBIINyUe+2anKc4D+YeonC7deijtU4
        Ssz4JVrky461j6zxEnQ6P7gCU0zqUrg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-3nFl5fS7Muay8tsTNh_jBQ-1; Mon, 04 Jul 2022 09:23:40 -0400
X-MC-Unique: 3nFl5fS7Muay8tsTNh_jBQ-1
Received: by mail-ed1-f69.google.com with SMTP id x21-20020a05640226d500b00435bd7f9367so7179070edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++fJgtu1Gsy4nJVDDaNos/TBbdlOhBzdbNWHZ5EkqwY=;
        b=dtj99vmZsTSSI5zW2cwYEqWN1imjBG4s+3ZupMLmChG507Ssz4HI1a38VCYVWRN8MW
         W/4T0M8qRCMg161+JAcagOQqehq2C5KQlNIaN6n8X+8oUi/C3Q4A3tR9km6P8A8V2V+w
         /NOKrqrPwJDc14amcSsQ0nbMnPydOx8wh4oCUcPEKlKU6Pbom9AKIw3+TQO5chFeYaH8
         3J6aUbozbGBFpGmbd/7wqtGLj3cQJKQdmhG5w5NYnCb4fq43RTWEj8GrcKlBfM8N68aD
         +Ie5s20GLrAywpM6rGVYDi8ait4mgKs8FTeEYUBhGUMrM9wd18vsBbzFC2NC0k1KB1Jk
         VmdA==
X-Gm-Message-State: AJIora9+/B1WR3yv74JDd1V30zib5Mqphhriac8wRQ2DR/0I5ccahYZe
        g7sEnbbflCse9WoH1K9SccbH9cn34gvm8++0QvFzJGnzzsnmMmPd60zHMXfmElKGVqEYjV56Aq/
        pw2Yni91mrfipJnaZWFIKd9hnakvoF/Kq0X+A7ZtF
X-Received: by 2002:a17:907:1dea:b0:72a:6012:7bbc with SMTP id og42-20020a1709071dea00b0072a60127bbcmr22739731ejc.258.1656941019233;
        Mon, 04 Jul 2022 06:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1us+BJZNsaBxoVlhuOHsDmDB0TuEnxFOGCQHinJXmpvFVRGrl2Z3hyJhPYMWd9HALphgmfV9qcRQ2n0jxT4UXk=
X-Received: by 2002:a17:907:1dea:b0:72a:6012:7bbc with SMTP id
 og42-20020a1709071dea00b0072a60127bbcmr22739720ejc.258.1656941019093; Mon, 04
 Jul 2022 06:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142515.14800-1-code@siddh.me>
In-Reply-To: <20220701142515.14800-1-code@siddh.me>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Mon, 4 Jul 2022 15:23:28 +0200
Message-ID: <CAMusb+QLOyOmk-MQ=FJV7N19g17TUb0gyBi522Rna1uTR9S2+A@mail.gmail.com>
Subject: Re: [RESEND PATCH] MAINTAINERS: Add tools/testing/crypto/chacha20-s390/
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 1, 2022 at 4:31 PM Siddh Raman Pant <code@siddh.me> wrote:
>
> This adds the maintainers' information for the
> s390 ChaCha20 self-test module.
>
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
> CC'd the maintainers in this enail which I had not
> done last time.
>
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe5daf141501..0fcacd715b1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17438,6 +17438,14 @@ F:     Documentation/s390/
>  F:     arch/s390/
>  F:     drivers/s390/
>
> +S390 CHACHA20 SELFTEST
> +M:     Vladis Dronov <vdronov@redhat.com>
> +M:     Herbert Xu <herbert@gondor.apana.org.au>
> +R:     Harald Freudenberger <freude@linux.ibm.com>
> +L:     linux-s390@vger.kernel.org
> +S:     Supported
> +F:     tools/testing/crypto/chacha20-s390/
> +
>  S390 COMMON I/O LAYER
>  M:     Vineeth Vijayan <vneethv@linux.ibm.com>
>  M:     Peter Oberparleiter <oberpar@linux.ibm.com>

Honestly, I'm not quite sure this is really needed. test-cipher.c is a
"one-shot"
thing quite exactly and it is not supposed to be changed / developed anyhow
in the future.

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

