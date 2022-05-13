Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E755269DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 21:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383537AbiEMTHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 15:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355664AbiEMTHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 15:07:32 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD12163BE0;
        Fri, 13 May 2022 12:07:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h24so3013707pgh.12;
        Fri, 13 May 2022 12:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G3htLal0R9JQlgB8aBD9qwg4j1ycq7FYDSReJvI/Ejs=;
        b=dfoLW4YM0AL0o2UMe/CAZsp0ISgrY14Zpen78cfYOkTh8uiK+/vttAkAdjMkk/14xy
         SkHEqwzygwbVdVYpB555V9s9B6LdrIpute6MioCLvnm4zn/4aCE4V34hLSOJKiPZEH+R
         DFOjPcVRQFQnqsrdSXpx5st7CfN3wgRoeo66SCZ2MsAPcKVK09+EUZwdQ1TVd5XyEBMC
         SfrmwLrwsouxzDDbrSsOz7sCUraI2aloN27/WaQAnF+PV6AHKAsXlLwW6VniVR3wJm4M
         EKV7KGQjAAewxj/+rPb1dBJrHkfcD601mRjyL0gdY5uh88LU338L/CUBP39wKlPeUH5a
         T8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G3htLal0R9JQlgB8aBD9qwg4j1ycq7FYDSReJvI/Ejs=;
        b=74xqoRBUrsMSICo/sUFay8QqnianTUVczxsH1JOOmDkXkRrld5xDxqLnexwlRkXvHL
         vOGe3pTcX/w1bA99JFBzoHomBL5cKxiTOwY5hWO2xpj4meYsIdIF0yNlIuFWWOpSMPAx
         hRUOY1SskECQHvdi2qLyAfvpMpzrPgi7o9fauPYGxAjhlRfCO2OALP9Jns7KyvA8+7+0
         FnKOI8jq0+dQlLiIBjX3A/vuQZeFlyObk8Br5k3GEdrCUl5D4l3kA0wAVGy0kJKjc928
         M4JRvEhmEcLQOQakLAyuM+v1K4UYcAdR4foVC31tmnmaiBpZs3dg2J4bTVEWw/+XYm5t
         TXPQ==
X-Gm-Message-State: AOAM5306Wx1POvbEpsjj0e0zMJXlxOGqvKtZBCBFPbdtLXawZW1CHYLZ
        xK6WlrO0jLS12uMKaWiYFH/DUeewgGBKEQ==
X-Google-Smtp-Source: ABdhPJzfFpaq1WOaqP10V9tGZ0QOROH6rY7aqAt6vYrrlF/byY/Hs88Xuipqk5G/jy3te8LF32mFpA==
X-Received: by 2002:a63:6989:0:b0:3c2:3c19:d661 with SMTP id e131-20020a636989000000b003c23c19d661mr5119901pgc.352.1652468851245;
        Fri, 13 May 2022 12:07:31 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:8d3c:fa63:aaf0:6c4e])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a428700b001dcc0cb262asm1948027pjg.17.2022.05.13.12.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 12:07:29 -0700 (PDT)
Date:   Fri, 13 May 2022 12:07:27 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
Message-ID: <Yn6sb1mzXuGyPZeR@google.com>
References: <20220429233112.2851665-2-swboyd@chromium.org>
 <CAD=FV=VX8EEgkeLgKwyKvjztcjbA8UhKOUpTr-sS1_Ec=QcWbA@mail.gmail.com>
 <CAKdAkRSOtAD6u_cwKhHeMLgz5dC2hfPvVvqmj+17b4i-nspfgg@mail.gmail.com>
 <CAE-0n50Y8tZD9Djn9TVaAiHxehFJ2cZKZ1Z09piDk47uw3nK+Q@mail.gmail.com>
 <Ynzf5jEIECLmELK7@google.com>
 <CAE-0n50+obQ5qgPNPtUY=OmTgU9bZQ3hNw+MaG9Wi3SQSc-i4A@mail.gmail.com>
 <CAE-0n52WVNru5fnyaB_7wcBOk4twL0Q92YpRbd40-o6ZBmbXWQ@mail.gmail.com>
 <Yn2YvIFNhaz5GmfI@google.com>
 <CAE-0n52ofANUWOY5h=Jjy5SYv=bnxO3xyN4cm3qGVRYmDtkNBQ@mail.gmail.com>
 <CAE-0n53VqYBP1Pq14ju5GWZ6VcKNS-DwLnM-1J_4Z3HExpMU1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53VqYBP1Pq14ju5GWZ6VcKNS-DwLnM-1J_4Z3HExpMU1g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 04:53:13PM -0700, Stephen Boyd wrote:
> Quoting Stephen Boyd (2022-05-12 16:46:22)
> >
> > I think I covered that in v3 of this series[1].
> 
> Even better, see v4
> 
> https://lore.kernel.org/all/20220503204212.3907925-1-swboyd@chromium.org/

I guess I was looking for the explicit verbage for when a particular
compatible has or can be used, and I do not believe I see it in either
the 3rd or the 4th version posted. I see some comments in the example
section, but I do not think it is enough.

Thanks.

-- 
Dmitry
