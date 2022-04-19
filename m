Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCEC507645
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbiDSRP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiDSRPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:15:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EC231935
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:13:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i27so34268158ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTJziAao2qjs+uzVN3EQ0D56BQ/OVvAsLtpYcVjVn+A=;
        b=hG7NRAEqY4fXRKjEEWouK2EPTs8ZUbSum41yScHVPKHzQW6kRIsvIQQf7MKFysPouZ
         rMDSDrcUrcIxCR5H9c3YC5aN/E5iCNA0oeWmYSFd+shc2Tt3ndKZtfjXn47Mib49TtfW
         L2SH72XksWJ41E60qngH1Jd5/XWOPf+6lD5741CqB59FY04TDi4o21+/+uKgDDSBemXa
         2corbY0VeDFDsDZycBgtykqOUW3SZDEJ2Z1uuUjq97DC/eULR/VT5kvzc87oAxook6R4
         01cEMSW7j1JvKlHrWApUdOmSyOJufn70BpMyFCyA86UXwOSQUNVKnqzd2r5yhk+roibR
         DQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTJziAao2qjs+uzVN3EQ0D56BQ/OVvAsLtpYcVjVn+A=;
        b=Pd5DsxH+0Lbx+AoL1xGy7ZlkVoMjFkx1OH84bo/Om0GcuUIb8O7BMcpZx7cWRyLAyb
         z9O+QTn80mYqpdDlMDnVhK4z0mFKtTZX1ygphVEMwlK5suybQAZHkAYEMWGbeTJ9vbNm
         jqMts7y1rOPT1EHqm0qLJnjwgHKWQIcD0aTCuKAaM50/TygyTWXp858TxS7esfPVTiCO
         u+ZJpwvzzBW8vc0HfpgoYPoISUCAXGfpIm6H1d0E9oR500b9G2iUhjxdMvvS+fvZMuBf
         g3ahribU65cL3Eh2yi4VV8HOg4LVxClYL2TkYd0WDNUMkbfFM7R3+N2vHKBNAvnC6ZSF
         QR8A==
X-Gm-Message-State: AOAM531DboMPuImr81irTwQtHlW3ZsIwTShnODiAK6d4JR8UozFhyVy/
        skrtB5NTVv8y8Yx/kGZcCHQ=
X-Google-Smtp-Source: ABdhPJztdX9341/dhGDD0GY8ytvJkIc4J64GZtUxVsMBxk3Z+Nitg/4B9hvwDcDK5TIji2yzfgyXrQ==
X-Received: by 2002:a17:907:1693:b0:6e8:c7e5:c297 with SMTP id hc19-20020a170907169300b006e8c7e5c297mr14963188ejc.138.1650388388796;
        Tue, 19 Apr 2022 10:13:08 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906144b00b006cf61dfb03esm5876958ejc.62.2022.04.19.10.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:13:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] mm/highmem: Fix kernel-doc warnings in highmem*.h
Date:   Tue, 19 Apr 2022 19:13:06 +0200
Message-ID: <2147048.ZfL8zNpBrT@leap>
In-Reply-To: <6767543.18pcnM708K@leap>
References: <20220418175638.30018-1-fmdefrancesco@gmail.com> <Yl7MpmsXtzOfztHu@iweiny-desk3> <6767543.18pcnM708K@leap>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=C3=AC 19 aprile 2022 17:09:04 CEST Fabio M. De Francesco wrote:
> On marted=C3=AC 19 aprile 2022 16:52:22 CEST Ira Weiny wrote:
> > On Tue, Apr 19, 2022 at 03:25:16PM +0200, Fabio M. De Francesco wrote:
> >
> > [snip]
> >=20
> > I think you should gather all these patches together into a series and=
=20
> submit.
> > If I am following correctly there are at least 4 patches now?  But I'm=
=20
> unsure
> > of which ones are stand alone.
> >=20
> > It would be easier to see what changes are being made along the way as=
=20
> well as
> > the final result of the fixes.
> >=20
> > Ira
>=20
> Yes, this is perfectly reasonable. There are only three patches (this=20
patch=20
> plus two more in a series).=20

No, you are right. There are 4 patches in my queue for Highmem related=20
files. I think I'm at a point where I'm starting to lose sight of the tasks=
=20
due :(

> Since they are all related in some way, it is=20
> best to bring them together into one series which I will rework taking=20
into=20
> account both yours and Matthew's suggestions.

The collection of all these patches in one series is confirmed for all 4.

Thanks,

=46abio



