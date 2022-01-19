Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7DA493B80
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354948AbiASNzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354896AbiASNzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:55:52 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2319C061574;
        Wed, 19 Jan 2022 05:55:51 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id r15so4642315uao.3;
        Wed, 19 Jan 2022 05:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SKB+2gqwkmhRtvujHObAiP9QZA52p+CI6WHOcuhFGvs=;
        b=eUmHCDw3wkS0lUrAB+dFozV67Z/lrxEZLfdOsHGpbjZjf/IGmx4wrYpyfYNb8b/n0U
         wsQljeZuQsKBFT+WEsz5my5qMD+P3YaU4uOwq9YrVW8yNIow2nsrFZyu2O05i244dHk9
         Dqa7CBlNQpqftWj2tfUzOUmVGA3cNrmBpHru4/6ar2KKmtY58jN7SqAvg/m9cKXaU/BY
         Zg+DkyqTi/cBEVzUW9abyDk28qh14oTPk6AeqziJLLgdDxOMYRCsAQYPa9Tf3w4ZuhT7
         W+ZjndhlALXtwXaS5/aBNk/lJisvMPxu3kdnLncL060EX83mSEEg8m8/2SWR+Y2GkwY0
         3ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SKB+2gqwkmhRtvujHObAiP9QZA52p+CI6WHOcuhFGvs=;
        b=CmzluWE/+EerR+lgsjMulrYOCGrOTi/cl/siHLQWVbPumtiDdWEJBlmW5a5XTVtIeI
         xPn44GojQ2UVmeGrMT/DilRxZXQg8qerGLQPWCjMBiuOcuTmI7T0y+gyVoRShlYYEmJW
         vxE4/G4+b6TqKYlIFt6syuuwYxGmS8whxOTRIe2as6eUzgh96QoQAR9zYwFo2Nj7X9IW
         2VWZQYa/hNlUXEMwGrJgRMRuOFwSf1rnLxP0eT6KTMGILpXHiTIJjfz2+8DAS/8jzc/5
         h4Ontvwu4Or7YAnKMgDSjq/cgUah17Pg8neJx0XbMeUeOd0LKKbkhcpTUrxbMkk7xdfP
         Jfaw==
X-Gm-Message-State: AOAM533ZFaJV5mBXteOMgzIMstAJ/G0oT9DQS01aOcSElbXzqdts4mqA
        jEKT5hgM0Osll+fCVSq+F2HJ6e1wkun0fDGAnCo=
X-Google-Smtp-Source: ABdhPJwMAzx9yjy9ZymirKauhj5j++PmaIjJ6L+QWvrMT9gAYuDon288paA6SJNFakl9aTsokpI9doq/OxtxK5AOQ8k=
X-Received: by 2002:a9f:31cc:: with SMTP id w12mr12500442uad.46.1642600550848;
 Wed, 19 Jan 2022 05:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com> <d46fcc03-40f1-edbf-e966-e35aabf84111@arinc9.com>
In-Reply-To: <d46fcc03-40f1-edbf-e966-e35aabf84111@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 19 Jan 2022 14:55:39 +0100
Message-ID: <CAMhs-H9j+0F_9GgTfFfPP=br61pZ9PX=ndu9apnA_Fn9k7JEog@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] clk: ralink: make system controller a reset provider
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, erkin.bozoglu@xeront.com,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 2:27 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc=
9.com> wrote:
>
> This series fixes the SPI & MDIO probing issues we were having with our
> mt7621 board.
>
> Tested-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

Thanks for testing this!

Best regards,
    Sergio Paracuellos
>
> Cheers.
> Ar=C4=B1n=C3=A7
>
