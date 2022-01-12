Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718BA48C306
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbiALLWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiALLWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:22:34 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BF7C06173F;
        Wed, 12 Jan 2022 03:22:34 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x7so6881006lfu.8;
        Wed, 12 Jan 2022 03:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i3J9e40/qw3RUUYb2b020SFx3wJaeeIDSrRZNGkXFSw=;
        b=B/DwJAktTSBHU8JBc1OwYod+gQ8oHU59G2zVu6ltzgGb9oZ9jKl3qkivRBVYKkgsgQ
         4UnbtFtN1ScC/nRIGs75r/D3pa9CqJQbq0TyU7HKjWzMljvj3U2yobOmNYIJbKz81r5/
         vjs1K4ISERXlxm2gQyCFK4DjL1Iqi1fAadaSTtx3YM/R+rpvGvXEXwN8MlQtL+c6QGIw
         OJZK5aZhG5MyMRpCpUgxQf0bGeoxc9+z6qXQVptzuAAmeScmsuAsVtYpZSwsV6hgBYm5
         TCh61UT5LjJJsCLOFtBqQWi0ZYJ2Cgq0MKPKaqgLVPjR5xjxkPUzKomvI6utpSJB6aYl
         joKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i3J9e40/qw3RUUYb2b020SFx3wJaeeIDSrRZNGkXFSw=;
        b=4lQ4chPHa968FliwMr9hMIhDavcwch2A4AAWeXw4lXsq38FkJxlzAJ20dMFtAwFxD1
         zfV+g5kZqpCoaUXxrhK69yOg4ovr45k3KwZDV5qtmeCdKcguId+S1l6IdHjaOA2kTk6K
         QQWJ+Rtqwnx52D+6S1+SxAH9OQUYXhNSDN5g4aKTUG9R8dahd5JhDFJRz6pVldJJPhZW
         1tEwczmTKyZI1hg9RMd+zNbCHL/HQ2U/JpqTSRdIEBMmuXVyRVJe5R8/eDYCPSp1YON7
         F5at2kebNMbMfkzvy6Rvxzrr8WyFUvVrb4NN793x45u9nMiNi66rTbabyDYEnWtwF5fb
         edDw==
X-Gm-Message-State: AOAM530Y4Z9t4F40R9WaqMRGWJOhdPRlmD3qc2qZGqmOhdWKyyCMxEE/
        Fvl+2aDDMbZTaImxZrCfEYuffO5432g=
X-Google-Smtp-Source: ABdhPJwi/QZFJP1f1CylCHF29BDSHvNiAczhugZC+6a/+Ffwq6BgcQKDeVkO5NYgP8eMQ09JvBuQMQ==
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr6658544lfm.420.1641986552730;
        Wed, 12 Jan 2022 03:22:32 -0800 (PST)
Received: from [192.168.2.145] (94-29-62-108.dynamic.spd-mgts.ru. [94.29.62.108])
        by smtp.googlemail.com with ESMTPSA id a3sm231510lji.133.2022.01.12.03.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 03:22:32 -0800 (PST)
Subject: Re: [Patch V1 3/4] memory: tegra: add mc-err support for T186
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
 <1641926750-27544-4-git-send-email-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0b584dfd-04f6-d7f7-f08a-003b89e557f5@gmail.com>
Date:   Wed, 12 Jan 2022 14:22:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1641926750-27544-4-git-send-email-amhetre@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.01.2022 21:45, Ashish Mhetre пишет:
>  #define MC_INT_DECERR_ROUTE_SANITY			BIT(20)
>  #define MC_INT_WCAM_ERR					BIT(19)
>  #define MC_INT_SCRUB_ECC_WR_ACK				BIT(18)

I don't see where these errors are handled in the code. Is documentation
that explains these bits publicly available?
