Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714835ADD93
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbiIFCwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiIFCwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:52:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E358C65552
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 19:52:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so6346023pjp.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 19:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xbLAZ8EomOdTf/PJLZrmWD8AyHmyj6muZVNU6dvfnNM=;
        b=dGCbKL+fZJValWDbQnzUFtwrGNDTzB5t3YFfSujn7JYPt03eRYHZHVun8Z5rdT4lc4
         oreblwss8NLvxHPjIW2ndNfWkOI7XDUAIwS4+m6j3jOIQxZTZZZhn1pGDlkv03bSVqpS
         EacE2SgvLKy8qnbAKcSfbo1FCOPQDlQu9jZJoGrfqnJseIqaVHJBmiGRHg412IyIP+8w
         iVDNXHy8Ilr5IhOypx5MGx8xOEAf9tlVHoCpcnQ4J9pXDm2L6sBqjadbsQGxj/H9gIGR
         N1gToIYlM2ZqPIYEO3RXRTj+LLoP3vX4TMkFZFUtNrGTupyS1PyKUcegAAkfzTQjQA3q
         Y4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xbLAZ8EomOdTf/PJLZrmWD8AyHmyj6muZVNU6dvfnNM=;
        b=B1IISGxZKdHfqO8dqIv+8MXLmH4UQvWtjQzLAdr+sKK6fFjP+VxNwypVrSHBSxTC1Y
         /VGHeJS4uku4UOzc27h/NlSfhVwejJktKSlfxjfE8hUeh8ZTA5iZFMvERAilOh2Ul8ag
         tT2zfAvuykHRcENEzFJjP0EXG37o1vjbpSQb5eHjqRy41CS9AumyNke3fR+eQ96T3dlG
         J2JKkx83+XumWo7Zby79PYWMefMiZaL6kiAyxFFCxchSsRvhxj7a4ErNsGbwH8u+z/30
         24m4YKcQHQ1UmGOsZPw1mIC5HBLq2ayqvRb355hb31U1bTbDMDy3ZxfFElAV/Jm9IOGg
         4Ojg==
X-Gm-Message-State: ACgBeo2hpuKvDbqPppNfoohx0kFATCJ5SVgvlUshAKtMpNYhgdTfRC7X
        u+ra0/7/PL3cEG8WVOTk3x9HBZaiEqSfuINJ
X-Google-Smtp-Source: AA6agR7cR+7qIJU07dBJP76b6LZTWTWrXy+v3LP+x2Q6MRZTN3lE7bDdfjqKgPKoo2gkzF1fyWuZlA==
X-Received: by 2002:a17:902:c209:b0:175:1a78:a170 with SMTP id 9-20020a170902c20900b001751a78a170mr34675882pll.45.1662432741435;
        Mon, 05 Sep 2022 19:52:21 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id d22-20020aa797b6000000b0053dfef91b0bsm285903pfq.205.2022.09.05.19.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 19:52:21 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A0230103BA4; Tue,  6 Sep 2022 09:52:15 +0700 (WIB)
Date:   Tue, 6 Sep 2022 09:52:15 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rh-kdlp@googlegroups.com,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH 5/5] DO NOT MERGE: full sensehat device tree overlay for
 raspberry pi 4
Message-ID: <Yxa135HNrFztZe3F@debian.me>
References: <20220823174158.45579-1-cmirabil@redhat.com>
 <20220823174158.45579-6-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JL88ZHhn8zfeK6Xv"
Content-Disposition: inline
In-Reply-To: <20220823174158.45579-6-cmirabil@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JL88ZHhn8zfeK6Xv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 23, 2022 at 01:41:58PM -0400, Charles Mirabile wrote:
> This patch shold not be merged - dtbs files are not stored in the
> kernel tree. We just provide this file so the code can be tested.
>=20

Hmm, if this is DO NOT MERGE patch due to build artifacts (in this case
dtbs), then how testing of this driver can be done with just DT source
(like other drivers)? Does providing custom overlay needed for testing
it?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--JL88ZHhn8zfeK6Xv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYxa13wAKCRD2uYlJVVFO
o5gNAPwMHaUxhbii/cyRnfLMdSGhlm35fNu4mvbZ6jD5HFVuSAD6Aku/MDnJPVmV
4ut3dE+fghstxX8j8p0tN4TlCPULRAk=
=HlGA
-----END PGP SIGNATURE-----

--JL88ZHhn8zfeK6Xv--
