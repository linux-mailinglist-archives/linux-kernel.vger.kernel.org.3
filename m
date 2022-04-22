Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E891150B3ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445808AbiDVJYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383688AbiDVJYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:24:19 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5038327FF0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:21:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e30so6156169eda.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wt+VIlBR4vfAR9VsDl1LN/6dIaP3ecpaOK7dqrqDVsA=;
        b=frXtCBX84ZOpbI+yX9gdu3zuxc3Q8B7Axk36QmI6gBXsfdfxfwU/42ulIK+DMpsftw
         he06S7C6b42aezaxfJ/P+ShxvvWeR/6+MeiE1c7hgu9I852zcH3yNX9h3RBE8NswTA8p
         Rf+0Q2iV6aCqA8RIzWMYnKvp2VH+Bno6TQozqHsZs04dSQfAjargHu0L4H7SYEe+Sw8k
         ZUwzFKcYPabbjitCvv3DObgRYRXQB0oIsFr3p2IPyoo5sK96kImyWbobxA+D2T+RTOlb
         GvhcsKvhR5PVRkFCEODN+9oaD7mos+688dPMnWD2Q4P6gIYyeZavA/vBT8pPZkeIX43z
         DL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wt+VIlBR4vfAR9VsDl1LN/6dIaP3ecpaOK7dqrqDVsA=;
        b=m9+RwMpsK0RV/loraRyMQL87ndfJRAic6HXoLlFGaQLAwe1jg+iFoEoPbXHeG/gYFK
         hno/mrEuGpTAE/x28qeNL9ljBYl4Ggr1mQMpX0YTHeSL1WRAPMVK7MMpHnIdo0akdg2e
         V0FFsICvmV/yPCwNwIo+klODXc2iF/dcPpTIfvf1wKspCi51XCJTwnYUGUTSBOZczBYK
         /djV3np96YIVB0RzGV8HzfHofMGdrxM9avNwAobHx14tdu7Br+9mLEgJ8lO9tpg3tTt6
         wnF/O3eu/FbgPeR1A/SSC5umy8gY8uVriw96hgr/CTXGJA6DvYyDc9AN//CJfqTzxoSG
         Ithg==
X-Gm-Message-State: AOAM5332YFl4gIN9HexAyPxYwg8WrcquyjjdTASV4euqaDhsr6SYg/YN
        UtbzU6UH3R8NKKhEs/6JT1E=
X-Google-Smtp-Source: ABdhPJz6xCx0r0yJZR9kIoAYflbzcSCWB675ihSQU6o2CsLcCZvTqv49GM/q9Nbauv8U2/taBKazVQ==
X-Received: by 2002:a05:6402:484:b0:415:d931:cb2f with SMTP id k4-20020a056402048400b00415d931cb2fmr3798196edv.287.1650619285745;
        Fri, 22 Apr 2022 02:21:25 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id l17-20020a056402231100b0041d98ed7ad8sm663743eda.46.2022.04.22.02.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:21:24 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho <mchehab@kernel.org>
Cc:     Vihas Makwana <makvihas@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Hans De Goede <hdegoede@redhat.com>, ira.weiny@intel.com
Subject: Re: [PATCH v2 0/7] drop some unnecessary wrappers
Date:   Fri, 22 Apr 2022 11:21:21 +0200
Message-ID: <2181149.iZASKD2KPV@leap>
In-Reply-To: <YmJGzwA0kD+lFtfN@kroah.com>
References: <20220411102136.14937-1-makvihas@gmail.com> <CAH1kMwT0gyQNB1-j62-2ntJD9Lobsmr8-5h6n6-SJ44wykMyHQ@mail.gmail.com> <YmJGzwA0kD+lFtfN@kroah.com>
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

On venerd=C3=AC 22 aprile 2022 08:10:23 CEST Greg Kroah-Hartman wrote:
> On Fri, Apr 22, 2022 at 12:26:21AM +0530, Vihas Makwana wrote:
> > Did this patch series get lost?
>=20
> What series?  (hint, do not top post).
>=20
> My queue of staging patches was empty as of a few days ago (it's filled
> up since then), so if they were not applied, please resend.

Are you also talking about re-sending patches for media/atomisp? I=20
submitted three patches for that driver between April 8-12. They have=20
already been reviewed and tested by Ira Weiny and Hans de Goede.

However, if I remember correctly, they should take a different path and it=
=20
should be up to Mauro C. Chehab to apply them. Do you want them to be sent=
=20
again?

Thanks,

=46abio M. De Francesco



