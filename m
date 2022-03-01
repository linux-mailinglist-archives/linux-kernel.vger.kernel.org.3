Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97794C8C36
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiCANDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiCANDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:03:52 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98F77B547
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:03:11 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p17so13364158plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 05:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=hryDL4Psc7A2DADVgS+/xZHfmqAye9BmCnsOUVUA4rd9Ub9SPy5xaAKBzTdva7Kt2/
         eOZeSQ7q4Sv8cOpwuozfWU5M0MINFjUMfJEHwDS6fEALqZ7FPXXHenYhmkGqNsqfnjH3
         HmK9ki1M5pJjidfmqc32T7AZs9t33O2FztlpY4JYJsxCvPIvytGc0B90eNdbqeSgMbm3
         mHPHcNfDbRYOEpqC7Uc2g5b9pXxbfgOntu4n60RLK4f+qKbFN1SPdCV+F5IUBasIl+IQ
         PPXamQS+idLuV/uR1YOCyyL+Wm3tq+rE7e3mj8G+Ob4AYS1ayu+x+XGWtuVtuq/Zvg95
         ldUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=mPf64gCZ69TMCU40Ped4Ma5zciJcaGAC9aHGAuzeY0kfsiZRy2wscuAgPR8MMe/SNk
         UzkyIAwtgPeIxj5WqY9Ll4wG6m3Etdl6TZJNTKxwyyqJ8eveYaHzZpEW5aXYWVGIOAco
         QJztTroYL6b/xPEmE9mOTPmdlmo+V1NPyb+E9yu00OvA+fNUkBsmjjghvZutj7K/3/L6
         UOLdfP9v94YG648cOSC7yw4YozQUlIkbIfmBx6WwjLMKwYPYs3akSW+V1DSNPeYSt2Tj
         h/aMog9tt27ryxSBu7Tpps2Ubzerrbjs2JxDO+bpWam0bPfGhBqF4EOL6iMFQKAkb9D0
         AMGw==
X-Gm-Message-State: AOAM532Dx0fqL0nsLYdRCbjxtN8kjyp6nPjrdV1VZ5Dm3qKTrHlFmNBh
        guyFpRXVgcdZbe+BH7S9Q++GTG/zM+IVKJ6US/akk2ovQ3EwWA==
X-Google-Smtp-Source: ABdhPJxmaOzkubA4LloKj0vIJt3HI5cp8/4dVYmXOY0G1ql0dL06gr2ZLpXtn8FLLm9afcQcAlomrk/lOrFHYIOZQMI=
X-Received: by 2002:a17:902:7044:b0:14e:e1b1:bb0e with SMTP id
 h4-20020a170902704400b0014ee1b1bb0emr25237709plt.65.1646139791286; Tue, 01
 Mar 2022 05:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20220217082224.1823916-1-hsinyi@chromium.org> <20220217083119.GA3781632@anxtwsw-Precision-3640-Tower>
 <CAJMQK-gDDtPT-kM56WodE=eo1UAZShbshLsuy_o-YuhorFe8mw@mail.gmail.com>
In-Reply-To: <CAJMQK-gDDtPT-kM56WodE=eo1UAZShbshLsuy_o-YuhorFe8mw@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 1 Mar 2022 14:03:00 +0100
Message-ID: <CAG3jFysk6X9g5X1bVW+e21tAAw8UuYOBAHbAnQi43JUF+6UhVA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: Clear the DP_AUX_I2C_MOT bit passed in aux
 read command.
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Xin Ji <xji@analogixsemi.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.
