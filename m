Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F060250D6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbiDYCIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbiDYCIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:08:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A78CE62;
        Sun, 24 Apr 2022 19:05:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p4so1139635edx.0;
        Sun, 24 Apr 2022 19:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3pvRJjhI6R4lroHj6g3A/ajjsXoERGIDfFflfPaFYGQ=;
        b=V/qISFyD9O5CMBho8+9ZH7gbXF7ekx4exgSj3WCjN9AFYsyM3OwLtSVLQqr704MVy7
         XZ0hMSe5QvtBGfN+9tAqAvYJj8bokoKeN37LP8Jc31Bvt4xtTHW/gP2Jcl17rZyvNeL8
         bz4Zhh7aYoIsoWcSYaXvSE33SF3uTlBmGVj2Io6x3MuOAwMHSoFRgcObH3wtwQJMf0SU
         GLk8AnRHDixX1OfJVNgum972UT7pPdEsVK3ItSX6bw0kNekRL2Vg6ImayOaCXGNvP1Yn
         /YzgXsJmqJsDqkohetRAM5ztIIOVeUadL/0jt5z0vrEPwmMHSDKAvOnQ3i3CilLZe2Hw
         Squw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3pvRJjhI6R4lroHj6g3A/ajjsXoERGIDfFflfPaFYGQ=;
        b=ZDhS5/kp2fgUgZFoM9pKIMn+Y54iMSeG0Rka2Y51x+HwCuKVBKc8j3fpJQbw1QR2Zr
         WueEigAYwyT9QRTtcspy4YRTXXrqWV0Dzj3yY/9alroZ/q0tP8bITeJgOF2GDPdTrO97
         v4ZSwPX/PfnT+xJ+J00Oa0j4Dc8888qVR+OVEwlVw+bu5xfObQiTOb7sO5vtwiIKWpR0
         MIJAe27IUBBqx5blH1/8aYMex94FGzX4yPKDbdzlXOZ+Jz+itQmBaIRhOf49j8Px7Vjp
         Ms/aVoWzW4tcXkG0LIaOgqieaR6ixehwS/Oq1kXh3FMSBijip1o2CaLfnM6oIN2eufF8
         YbmQ==
X-Gm-Message-State: AOAM532XZEDnUHNkdAVKbs6wjzllw/Hxi8CK+pYrws8WPbhhmqQ4Az+J
        9RM+VxQewU6KpF8wIeCSTuM=
X-Google-Smtp-Source: ABdhPJwcoZLdLkbGXJ2Qy7Z44OfAwOV+HXRl3H9+RH/qeMS2DUc4coAp+4WPYxrpQYWuomMvF+yl3w==
X-Received: by 2002:a05:6402:84c:b0:423:e5a2:3655 with SMTP id b12-20020a056402084c00b00423e5a23655mr16803202edz.28.1650852307377;
        Sun, 24 Apr 2022 19:05:07 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id z61-20020a509e43000000b00425e4d583e4sm824867ede.87.2022.04.24.19.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 19:05:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/4] Documentation/vm: Rework "Temporary Virtual Mappings"
Date:   Mon, 25 Apr 2022 04:05:03 +0200
Message-ID: <1822146.CQOukoFCf9@leap>
In-Reply-To: <1894872.PYKUYFuaPT@leap>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com> <YmXyhH7wAJo274WB@iweiny-desk3> <1894872.PYKUYFuaPT@leap>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 25 aprile 2022 03:42:46 CEST Fabio M. De Francesco wrote:
> On luned=C3=AC 25 aprile 2022 02:59:48 CEST Ira Weiny wrote:
>
> [...]
>=20
> > Why do you say this?
>=20
> Oh, sorry! I didn't mean to say this. What I wrote is _not_ what I meant.=
=20
> My intention was to say the same that you may read below about=20
> k[un]map_atomic().
>=20
> This sentence should have been:
>=20
> + It always returns a valid virtual address. It is assumed that
> + k[un]map_local() won't ever fail.

These two sentences should be better rephrased as the following text...

+ kmap_local_page() always returns a valid virtual address. It is assumed=20
+ that kunmap_local() won't fail.

Thanks,

=46abio




