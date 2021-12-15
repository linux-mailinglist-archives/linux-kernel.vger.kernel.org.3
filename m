Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADE4475252
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 06:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbhLOFzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 00:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbhLOFzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 00:55:51 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7A7C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 21:55:51 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 8so19765972pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 21:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=or349biYLFpL+w0ZA3FfJe1BgIFAwbYkc2y2ZXxAeHw=;
        b=kDowek4cSSKDkV4UGyJuXyqi5JIWAReO4OxHgYeFCA2HgFjEt1CmeiAM/M29ggFdWg
         zDA/vFKSK9uddEPsw6wgIXwmAHpCHwIGsC3J/1ibKr0pCY02/gmpC/7BEgpLr/c4ATlC
         L3nLg9A3lMltpboAcgF5Vbiohm/XRqfAc6EERoIOQoo/W0TrNgmv4Sgo3e6xJjP+J/19
         4hBUComVDTtx8ThzXRwuIHX16u61zSn3cVAorIsKN+qBdjiiNhlbPIqoOlNh/vYW33HJ
         9LaKqv8Cfwn8Hk4NM7gRBQU/s3wspmVc7BIW1GQm67V9cop79vBDzKcQPPSZmi3etjlo
         An/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=or349biYLFpL+w0ZA3FfJe1BgIFAwbYkc2y2ZXxAeHw=;
        b=mPmD9nGS+2y9z7u0kmuVkSCabee6y6Pmn0LQCoBulTLJUd3QhccOb2zJYOsKb2VOnw
         SASPIoDRb6+Lm0ofhTCMtHpoURri5GK6rqh+PBghQ/myowyj7w4AF63Ef0unsGt51CT5
         tc4Dse8FBFimu3U2z7x/zq1OvAICy7KY9JFAmfCG0eppxg0MRb2yUsIGnJ1Mx4f71Car
         cg1CmexIr+/2Zg8+kTspFScVVTL03qD507SPcoKFrYTB7snrEj15eyk2ZMNTetgewNia
         eG9MFjubF9uQrknB9N6RNFcl72sJ003yzljuDRrNKgIp2X2BDaJIZ358unWMtIhMmtIK
         Ochw==
X-Gm-Message-State: AOAM533+yK2CFh32PrFBkonvj/f9R/gKnkFFzrj/PgKZ9TaEFQ22tj4C
        lr6o+wSSW4eULrBmf/3OsWsrfg==
X-Google-Smtp-Source: ABdhPJxJk9jvjtHfRNmilmy4wTT3wZeaD4iKsJSZSfKzYHurbYvLQ7MyZFm9b5pPFVNOYSjjm5goIA==
X-Received: by 2002:a63:102:: with SMTP id 2mr6802124pgb.311.1639547750606;
        Tue, 14 Dec 2021 21:55:50 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:754d:1c44:62a9:6d30])
        by smtp.gmail.com with ESMTPSA id k22sm1015260pfu.72.2021.12.14.21.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 21:55:50 -0800 (PST)
Date:   Wed, 15 Dec 2021 13:55:47 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: mtk-vcodec: potential dereference of null
 pointer
Message-ID: <YbmDY9PbQUlHgyPF@google.com>
References: <20211215052157.94172-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215052157.94172-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 01:21:57PM +0800, Jiasheng Jiang wrote:
> The return value of devm_kzalloc() needs to be checked.
> To avoid use of null pointer in case of thefailure of alloc.
> 
> Fixes: 46233e91fa24 ("media: mtk-vcodec: move firmware implementations into their own files")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

With a nit:
s/thefailure/the failure/

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
