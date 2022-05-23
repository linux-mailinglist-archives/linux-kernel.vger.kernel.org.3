Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44414530BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiEWIro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiEWIri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:47:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1CAE0C4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:47:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d22so12472069plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IEAer1lH79NsmLj4b5VqaXj4C4eVbt1HjEg0g160lbI=;
        b=RS52x6K8aaLtOUtyjhbX8/n06RZFlA/wnY/b4ugsdTB6rtCdZNckdrk+q+PSnDp/uZ
         MjG1OsdMd4/vIVIN5q6m7rKNQ/a1CdmZgAQdbJ5gpUkv3ofEKhjnO4mgukUkChGYjA/P
         uMjO+HEad9Siw0Zm62i+OiFRZDeIHIqhh8Ot1gDONcYgr4ueUcVKSMz4mnKNf6tNg6C3
         8LAr2AATJlQLUzy3JhVDcvclNIsILd0ntm6IiXWS2XC1viFsYaNp1UDPViaiiXerHJ2b
         BXe/iGOFtx3mDNvlwCSQFPatzSB8frjs2paelFNTBZZRIuOp6trWVAcZ5pN0+4g12+Tm
         Ls8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IEAer1lH79NsmLj4b5VqaXj4C4eVbt1HjEg0g160lbI=;
        b=F7baddthCWQC0g4IzJoTz83IUq5UyI5r6CwBPKAPONQ4ZjBWjU668EdUCblmaH3h7t
         tu4mGuZbWtF6rDe01k4fG1f1WIdDRqslvR8ZJfMGEyx0L1E/4y7PqwHfs8TaHnMnPc+K
         EbdzcR2ZGCz8T52Wr2AQb5L9iJ/OZKRF6R6uLGlbyMckIKh7HHHrysjYTx+62mNHpus5
         UF/fsv0Bjmi8+bhDn4tBbIkcUJ733Rz9dS0322NI95npZqk+pUgY9U9hXFM0jBW8EHgZ
         Hue05uEWseqggEHsEkJgbEqxcu/uNvOA4kwI0RnDmUPWnE8JdDB9+cQcIqIMo1AMlB0x
         oWSQ==
X-Gm-Message-State: AOAM530veuXDHc1lf3CIlusp7WsaxP4NfZ9/6siUr6CD7BGNitrGDgeB
        YGjS/TL8qDajgZzoFqAf/PRgcSU+kK6dyPUSIEi4lg==
X-Google-Smtp-Source: ABdhPJzq974GhyP1VI37htI/dS8x/+HyuWBzEzGCeT91yupIDi7F6pNhNwu6DXsKfT1W5hbpCB6kxmFzxG3qbFRdaJY=
X-Received: by 2002:a17:902:ead4:b0:162:13e1:33f7 with SMTP id
 p20-20020a170902ead400b0016213e133f7mr7949190pld.21.1653295657262; Mon, 23
 May 2022 01:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220422084720.959271-1-xji@analogixsemi.com> <20220422084720.959271-4-xji@analogixsemi.com>
 <CAG3jFytWGSUM9mevHewdmEe-hq3JgB74s7_f0fsEQqkXr9VUHg@mail.gmail.com>
 <CAG3jFyvEYbwkdGtiNR-6vFEXTLjcyT_viqp9qeVxFTu0PrJEVA@mail.gmail.com>
 <CAGXv+5E1cCNWD98fMDjC38y2UztZd=PNQ+=G=wrBYfoXkswvHA@mail.gmail.com>
 <20220425091419.GA967110@anxtwsw-Precision-3640-Tower> <CAG3jFyvTim7P_y2G1Br5j3Pwz4KzvRjWgci_qQ3m_YW=3Bog8A@mail.gmail.com>
 <CAKMK7uFHyYTnGtP+vCzo2Uan90DW-QZpPFPn5S9bQ5aPiY=qzA@mail.gmail.com>
 <CAKMK7uHFGsPMZf2SUF4HDXo3XuOLjP3-DLfyp=gB2qpKR964Eg@mail.gmail.com>
 <20220523031324.GA3738288@anxtwsw-Precision-3640-Tower> <CAGXv+5EHghwSV+9Www9RvG74PkC7=AQuwn6sVG=cvCni-iwCyQ@mail.gmail.com>
 <CAG3jFysJLoQ2DMYw0oOfbQM3ifBmAhNLMxjPDEt12jq8sKCcSg@mail.gmail.com>
In-Reply-To: <CAG3jFysJLoQ2DMYw0oOfbQM3ifBmAhNLMxjPDEt12jq8sKCcSg@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 23 May 2022 10:47:26 +0200
Message-ID: <CAG3jFytVe3S4J4NzNVt5xkE-pM7+3e2cuUhe_vv1bETCpkbV=w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/bridge: anx7625: Use DPI bus type
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Xin Ji <xji@analogixsemi.com>, Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, qwen@analogixsemi.com,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        bliang@analogixsemi.com,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://lore.kernel.org/all/20220523084615.13510-1-robert.foss@linaro.org/
