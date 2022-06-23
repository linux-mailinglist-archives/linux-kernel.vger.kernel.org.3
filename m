Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47F45573AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiFWHPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiFWHPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:15:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E949645AD7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:15:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so1728458pjr.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2fI43SgyXceOE9zJuFaxscU7pPU4YThRfpSv6XVaZh4=;
        b=IP86r/di3Erug6zTbnaX/BM7fD2d8A1n7YJvlMk6qwRC5UKhm+qLDDqT5mSdhfa5+f
         1YjM3NQXEtEVWbsScEqKAPuRNVeZ9xhPebMkB/7eHe47GJDFyTsDgFhibCdxT5e5X9DD
         /OWwmqPICJcPG0279OlAszoVv1b4Q9szNB80gznG2k1tHKdZwCECYiofGc8CLgVDr7ED
         dJV6Bki1ZO55jwxKnKwhqfGWlwHpQ8gr++2+myBzyKmxWFQ8y31fDF91jxoVajh7FAcv
         7EuoYhRvxI3kj/m8eCAuZYD3dUxoW3hJaP+o+ky2Tz+/PN8zxsvPPyVQWXDgesFPFRLt
         BYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2fI43SgyXceOE9zJuFaxscU7pPU4YThRfpSv6XVaZh4=;
        b=whZpakdXntqWAqr545Yux0yBYGmQ8+x0B5qcOwaxfACYGcjV7WQ0xyyywhRhGh+Ojz
         AsKqWsM6Q1wEYQqVRlm9laHscPL07bqpx/rBwjcU2HDS7TCIUhGLfJROW8sNLmDEq8Jk
         Rmc6MANCmyLuUpf3hIP3VYdl01DxGdxhmnFMEe9YpaZCILkN1SG8JlJIR/Iore0XBqL8
         76EE3fTvz4uFdgPtGg4awiBHpVvKUCxBoucSRjIUNFqmW+25gMETaPVQ5ekzCTjsqf0Q
         v8gWq/PxCjXgQgT2oGjO9rnCpJxlCXQBpEj+afyln9oxr5YiBS0y5Jy4T4p0e3wsM5jJ
         pgzw==
X-Gm-Message-State: AJIora/QBs6OvVyH0Ru2Tf3M1wgZAxKyizaqDLhzUGPX2nywmWcAWThd
        W/dbyGxglD33QhFcsprZKVv1Cw==
X-Google-Smtp-Source: AGRyM1sVBSI+J5e/NtyVYmcNmQAKSOR6dZFz8jauZugXqSLa3BhAyJuXENsDC+KVKVF3KveRUa37Ow==
X-Received: by 2002:a17:902:e383:b0:16a:1cee:70c0 with SMTP id g3-20020a170902e38300b0016a1cee70c0mr21718522ple.131.1655968507523;
        Thu, 23 Jun 2022 00:15:07 -0700 (PDT)
Received: from n254-073-104.byted.org ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id g2-20020a63ad02000000b003fd1deccd4dsm14493181pgf.59.2022.06.23.00.15.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 00:15:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 1/4] crypto: fix the calculation of max_size for ECDSA
From:   =?utf-8?B?5L2V56OK?= <helei.sig11@bytedance.com>
In-Reply-To: <20220623061500.78331-1-helei.sig11@bytedance.com>
Date:   Thu, 23 Jun 2022 15:15:02 +0800
Cc:     =?utf-8?B?5L2V56OK?= <helei.sig11@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        berrange@redhat.com, pizhenwei@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B31AF851-9029-43DC-A9F2-BA0B3FBB0AD2@bytedance.com>
References: <20220623061500.78331-1-helei.sig11@bytedance.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 23, 2022, at 2:14 PM, Lei He <helei.sig11@bytedance.com> wrote:
>=20
> From: lei he <helei.sig11@bytedance.com>
>=20
>  * asn1_encode_tag() - add a tag for optional or explicit value
> =E2=80=94=20
> 2.20.1
>=20

Sorry for accidentally separating cover-letter and pacthes, it has been =
resent, and please ignore this email.=
