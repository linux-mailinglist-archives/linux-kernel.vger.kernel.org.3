Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DBE508CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355310AbiDTQCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351205AbiDTQCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:02:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773E144A01
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:59:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id s18so4587625ejr.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGFlvUF+6fFWy1fX1MYp4Kv8VavogLHQZ1swJRkagR4=;
        b=VrGhL5UriOqITgYWid/yHAnlnzX/ygVds9FFW9oUPAy99QMw4Z8dDJZytWmZzwf2Ww
         OWB7+EYY6KulPcWe7U5xX0b47etDOjTYHT+jG9wyOAQF4hXjDukNLZuNdYLbadf7D6Oy
         sYrAmLi0Lwj4VofOM8/nN78y8+yJ2Hf5WPYJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGFlvUF+6fFWy1fX1MYp4Kv8VavogLHQZ1swJRkagR4=;
        b=vtfh1eNC8r5vrtQWMvgoY1A+Vjrv/vgKbIAwC+/lG9KtP59/OBFspVJ6/Axdmg0Yv2
         15VIeWKnp+TA4E0QGCySwAnSICSkS04W/NOoCH46eNpJe72i0KSyTnxj6DwDxjwOdgQW
         2ZEuGrUBSXDjrTgVj6Wt0k+vjiq9kxMaizj1F26zghEEJNuEnQRKyinuC+rLgYvjsm2o
         1AsQDA4MeaLoZGiRMJkFOGUITcJ5cDBR2G2M+ZYNX4gcSx3Rm21kzoUSJ1CKH+EPLXZX
         IZ0lQB1UAt9Ths+lhfvSzX0FbNYb9BhO5/oF4xRezHIcTynWYS4S4gdTtr5vHvrYamBq
         TUcQ==
X-Gm-Message-State: AOAM533joPXxJe6GhrCJrT6PhI+QxZRrF5UtW57BaS/Y238FD1giKgxl
        fYpsyPbmy6/loNswveqqPfeqXyPrInDxLDIM
X-Google-Smtp-Source: ABdhPJzGgukv3K1cZEGdBlI30pcvTp7cT2L2KgyCdJvRj4B8ydBpJHR7Lr+oOHvkazE+SpETgRPYFw==
X-Received: by 2002:a17:906:974e:b0:6bb:4f90:a6ae with SMTP id o14-20020a170906974e00b006bb4f90a6aemr19770214ejy.452.1650470374773;
        Wed, 20 Apr 2022 08:59:34 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id lx17-20020a170906af1100b006e873dd9228sm6815185ejb.52.2022.04.20.08.59.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 08:59:33 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id w4so2856082wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:59:33 -0700 (PDT)
X-Received: by 2002:a05:6000:1acb:b0:20a:a4b0:dbc8 with SMTP id
 i11-20020a0560001acb00b0020aa4b0dbc8mr7616987wry.513.1650470372923; Wed, 20
 Apr 2022 08:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <1650439639-28428-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1650439639-28428-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 20 Apr 2022 08:59:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XZjstRUd7tP=2ZhFMFDYtsKkzY3D5-L=UU2wD5KHXGmQ@mail.gmail.com>
Message-ID: <CAD=FV=XZjstRUd7tP=2ZhFMFDYtsKkzY3D5-L=UU2wD5KHXGmQ@mail.gmail.com>
Subject: Re: [V5 0/2] arm64: dts: qcom: Configure CTS pin to bias-bus-hold for bluetooth
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        quic_msavaliy@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 20, 2022 at 12:27 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> WLAN rail was leaking power during RBSC/sleep even after turning BT off.
> Change pinctrl configuration to handle same.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Just as a note for future patches, you don't need tags on the cover
letter. If I respond to the cover letter and add tags it means that
they should be added to all the patches in the series but you don't
need to carry them forward on the cover letter itself.
