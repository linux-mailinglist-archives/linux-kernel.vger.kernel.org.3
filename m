Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388E95ADD8D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiIFCsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbiIFCsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:48:25 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E276BCF9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 19:48:24 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id q15so10005435pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 19:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vy1dd4v/QkldIALv84oBgnLZkWcv5J/haLShQvRcof4=;
        b=nf1NxQyRrSbGW2UvM228JqRH/pOaNkVEjj6hLtOd36Q4hjfbJKcJBSnZH6WxbbXT+x
         w/fxjJo/Uq7JT62ghcaqo+xquM/f3ikmdOQ5pO44CwSXiJ9gFgSBx3mI5R9BHWZZh0U0
         jfwoUThaFNuiqNeaTCcv+ERYCVKhxJg2bVTliFayrPrPVY3ZlHIrqNuX2PhSKnu5/4kY
         vJ0nhBWFsTEGFEQbTYI8Wt44tKRzbbjmyD/EmnNuEudmg4I2qTCTG0aTG/lcG+un0a0f
         HVxkDy8b/yw4k9gbtLz4iybANHnatF3g2O5PyPE9NbhVn8WR6ONAkkHJ3JfSmzHEQaRM
         M7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vy1dd4v/QkldIALv84oBgnLZkWcv5J/haLShQvRcof4=;
        b=oqkyHHLEAhtHX4XXIuvqpfwdcdbDF29knrFPMEBWIlX424obQMQHw4p0YbLxH9fF/F
         FMJtLL3opT1RuFf5TaZX78SJtD7I9gEhWx6/NabMKTSYvl2Q6eNRrjWSXItMEbjfHiqi
         jxd4/mazbvxcYwYhkFpFpISKkRmr2x2nY2Chs83FmuB+vOxLlVz6td57V11el9gHMm4W
         GVEUNYqOJhJzCVc0UKw8RDfZnNSVRtwLBm3M/bppsmdW365YOdG/OCoIjVeL0RAJpdTg
         8j70Yzii8414gZuwYB+QHNd8DlT7W+S/G2fWo8iWqrmSKbcXqNd8kswwsdri4bukhHUx
         lT+w==
X-Gm-Message-State: ACgBeo3xcwt7veUEkDd+GjTYb+KEAa3g7SvFG2H+oHSn1XPLgsiT2gGE
        m6FOO5C9EMi7Ey92neTSSrQ=
X-Google-Smtp-Source: AA6agR5sBi3xz2zfxDdMiK7UB+MKB55ykrPTtQbwKmxW6uvJZMcLtrckI4Cl6Iza3lK+cJK1HWGDiw==
X-Received: by 2002:a65:6bcf:0:b0:434:9b4d:82de with SMTP id e15-20020a656bcf000000b004349b4d82demr1712628pgw.63.1662432504509;
        Mon, 05 Sep 2022 19:48:24 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id x12-20020aa7940c000000b0053b208b55d1sm8620346pfo.85.2022.09.05.19.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 19:48:24 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4ED60103FA9; Tue,  6 Sep 2022 09:48:21 +0700 (WIB)
Date:   Tue, 6 Sep 2022 09:48:21 +0700
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
Subject: Re: [PATCH 4/5] MAINTAINERS: Add sensehat driver authors to
 MAINTAINERS
Message-ID: <Yxa09XFxcqy9zhuI@debian.me>
References: <20220823174158.45579-1-cmirabil@redhat.com>
 <20220823174158.45579-5-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tr8ww5RoLmsViCuB"
Content-Disposition: inline
In-Reply-To: <20220823174158.45579-5-cmirabil@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tr8ww5RoLmsViCuB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 23, 2022 at 01:41:57PM -0400, Charles Mirabile wrote:
> This patch adds the driver authors to MAINAINERS.

Better say "Add MAINTAINERS entry for Sense HAT driver."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--tr8ww5RoLmsViCuB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYxa09AAKCRD2uYlJVVFO
o6zMAQCdozCdatJ1EyXotkGEit32LByxTslyjLaE3VlufCSQFgD9G++inIYVP+9M
qYzU6HE2Gdu7IFNQW8PLbkOQKMhU2Q4=
=+MlH
-----END PGP SIGNATURE-----

--tr8ww5RoLmsViCuB--
