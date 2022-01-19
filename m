Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4705A493CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355604AbiASPMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:12:37 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46962
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355628AbiASPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:12:03 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 82E8540027
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642605119;
        bh=drjzBd6xSh2W3A1sdcF3qLyFND0naAGILhzsS9dD8A4=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=rlehtBxB6Z+y8+bmc22pQ0zkwX03Qq7d390fyUVpYt/BZ7TNZSdNgfNVdS4r/8UfD
         vx6iDqD+UAXp0610d4PUb1De9ZyyLrOE5648BAB1ba3Fe2KofzymOal/cCHT2Yt2rA
         kmlRGst5/ybvu3jeBtKhB8NtjJKggrzL8In/9MusyN4tpVhsNhPbaUe9Eg6to59R9Q
         CQF3tp0+t4Av8LXAcOId9Pi7ENySI9scQwrsuWQAd3BfQmQ6ZmsyaNTEcA3R9LaXEh
         8xpWiSxVca9fezsR42iLXqb4BDXgGcvIghk2eJcAwr3lCkfUD15JXfqJHv6zwq8Gve
         GAlMcZkhBB9bg==
Received: by mail-ed1-f72.google.com with SMTP id s9-20020aa7d789000000b004021d03e2dfso2769646edq.18
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=drjzBd6xSh2W3A1sdcF3qLyFND0naAGILhzsS9dD8A4=;
        b=0XbYJepV8kauSfsfoLiTG0u/pJg/Wn+5j8VRtDhCVneZwyv0PD8UoTZThcbFojxAEl
         m3hk164WLmGA3f0fAVofJagb/53mTq1pG7bXqya/PWlmeTd74Hhya/NTG9GucUYc9wZm
         oZgB+Beaey2wcu6J3bJPedUiDzz3oD1pz2wys+GgTWWJY4+sAyK8pI07BI+otpEvCYV0
         CsDREhs7tXsRqV/xdr0RaO3aA/LAk6KS1UHCfT4IdcaqSjdPA8bf2qkNnNoqqVQ+y/pg
         yb3MYbhm2LpNvRD7Ny6gohdPt4tRM+JITfyEz07nEC1puc369KYaMQO0KD9oFETcazv0
         2D1A==
X-Gm-Message-State: AOAM532e0q0n0sEfLsHj/heMlrW4pNN03HpPJ3wal/ayNPFtXPiVEIqG
        WGYMOhaKFQGAjv0jPYE8h1WrMneJ+fu8Fv9rc11Eu5EBJ1fH7klnZzl/o6nPzu/b77920WZ8WpS
        gU+cwJiLvcJ37mklnJuuLu4IiuaR+CWAo3Ky0Pzee8A==
X-Received: by 2002:a17:907:90d5:: with SMTP id gk21mr24657787ejb.359.1642605118417;
        Wed, 19 Jan 2022 07:11:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxddTNyN9TBuuv8pGuZnGAB9t/ygdDr/3nax3MlitJXfQZJieVWGTj2hsRfDZn1PRaG5CZVnw==
X-Received: by 2002:a17:907:90d5:: with SMTP id gk21mr24657762ejb.359.1642605118251;
        Wed, 19 Jan 2022 07:11:58 -0800 (PST)
Received: from krzk-bin (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id i23sm1339989edt.93.2022.01.19.07.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:11:57 -0800 (PST)
Date:   Wed, 19 Jan 2022 16:11:56 +0100
From:   'Krzysztof Kozlowski' <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, 'Arjun K V' <arjun.kv@samsung.com>,
        'Aswani Reddy' <aswani.reddy@samsung.com>,
        'Ajay Kumar' <ajaykumar.rs@samsung.com>,
        'Sriranjani P' <sriranjani.p@samsung.com>,
        'Chandrasekar R' <rcsekar@samsung.com>,
        'Shashank Prashar' <s.prashar@samsung.com>
Subject: Re: [PATCH v2 14/16] arm64: dts: fsd: Add initial device tree support
Message-ID: <20220119151156.y2rzrk2gpoweiofc@krzk-bin>
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
 <CGME20220118150108epcas5p2d9cd4db7cb368c2bfbd7d058eba4107c@epcas5p2.samsung.com>
 <20220118144851.69537-15-alim.akhtar@samsung.com>
 <43e72d34-0e11-9ff6-6924-0cab62b51891@canonical.com>
 <000301d80d46$502ae590$f080b0b0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000301d80d46$502ae590$f080b0b0$@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 08:37:40PM +0530, Alim Akhtar wrote:
> >Similarly to previous vendor-prefix patch, please let me know if it's expected
> >me to take it. I assume no. :)
> >
> I am expecting this will go via your tree, but I am ok either ways. May be you and arm-soc maintainers (Arnd/Olof) can take the call here.

I can take it, that would be the easiest, I guess.

Best regards,
Krzysztof

