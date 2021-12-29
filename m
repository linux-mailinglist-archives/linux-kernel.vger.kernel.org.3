Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DE8481012
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 06:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbhL2FgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 00:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhL2FgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 00:36:03 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A3FC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 21:36:03 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c3so1894758pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 21:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LCWTLU499vgUIibOB7RC/Lf29OvyjLAfzziGpa9pprc=;
        b=UHG2Wr/bUh9+RG3z6/wLDKvolZg27kHxzETT+w1PyYUO0M/sEDfnfDaXFK1/Fe+EgQ
         EPmePdb9FtgIXRoeOSmBlqYRDCHjdVhn5U3zfC73wvgE9tX1KbrJH1jfp4d9PlDGU/XQ
         WN/0TGLd8cDAoQlePh8eUjttGzfucKl1hZPjfzGSC0zx4iosSx7jERUbeqLcHxD1Cxfo
         lcoILVOjDWFPER13QQjV2dxLhxvnSaNP2wnyqahYu84szMUf1fvfvQZr6YYtlaI5wHbk
         RCareXx3mv9jLuqA1CDDe+stKGjbppVraM/vQFxLpzLq2BY9y8oEUIp+Z/T5s5sQNUgp
         GWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LCWTLU499vgUIibOB7RC/Lf29OvyjLAfzziGpa9pprc=;
        b=sR6QNf/QblQRyvbhoPMRJ9oyHMXNnUIFJ3lVeaibj9ZdaYLBASPfc0nT7xkE+b6N2l
         Hd9Jp4mOryylgQVB/8Runbg0avJMx6YzoqVPm37R8jVvhpeOVizMfqWINKJ+V3TPD/Yh
         bUaRmHJxWatTaivIJqBCEZb6ZVFZLpg1uIOf64YM1xAhcg2XyggI47ucJ8nubjEDNrOi
         /zdGKRFcRbqqM+gblyVTqzcw8EQ6BG5a2R/cSNw71P+mAD7N8VUj3movP0N0sC+x8tFG
         uw2CD7/nzD/Ix50m9pnvq6hAVwtIREpjDlK6dNQaHxYecekj17k9SBEOBo++Yvp6C8WV
         MzeQ==
X-Gm-Message-State: AOAM532xR3bh6ARG9Pb2pedaQ+/tSyeiFCYgQlMQgGupBL6/Ki9h/P94
        HnnNBGg0f10vA8KMtzLM+BgW5g==
X-Google-Smtp-Source: ABdhPJwI3ybkjKJD6RZt2826LHFESA/M3BbWEhFyh7OncX6wgaoW14cNyMMqRzWh+NFFFl1UtWzOSA==
X-Received: by 2002:a17:902:6b02:b0:149:7c20:c15b with SMTP id o2-20020a1709026b0200b001497c20c15bmr13898631plk.173.1640756162651;
        Tue, 28 Dec 2021 21:36:02 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:4dea:2b20:ea89:724b])
        by smtp.gmail.com with ESMTPSA id w7sm23509460pfu.180.2021.12.28.21.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 21:36:02 -0800 (PST)
Date:   Wed, 29 Dec 2021 13:35:57 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2, 01/12] media: mtk-vcodec: Add vdec enable/disable
 hardware helpers
Message-ID: <YcvzvXQ2Yov3OSvZ@google.com>
References: <20211228094146.20505-1-yunfei.dong@mediatek.com>
 <20211228094146.20505-2-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228094146.20505-2-yunfei.dong@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 05:41:35PM +0800, Yunfei Dong wrote:
> From: Yunfei Dong <yunfei.dong@mediatek.corp-partner.google.com>
> 
> Lock, power and clock are highly coupled operations. Adds vdec
> enable/disable hardware helpers and uses them.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
