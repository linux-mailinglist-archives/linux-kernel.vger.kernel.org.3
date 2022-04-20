Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AA9508879
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378631AbiDTMv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbiDTMv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:51:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7EC3C73F;
        Wed, 20 Apr 2022 05:48:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g13so3343814ejb.4;
        Wed, 20 Apr 2022 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=Yc/wWn41RLKXg/XnDWEYh5EY0Xa2lFOxeQbAbMbqZYE=;
        b=mFollUCiD/7FPhy/UtL32X3UWDXVIzB74hr0HCmsiE+XPsdckXLcOjGto8kpiHZBGK
         EkQHXhBsLlw6b85PDHQzvL++X3mouWrdjEp8glXt8nqZ+2uD2fK1bI8mM6+DUnnBC27q
         QM/JuTnvFlzkgYNH0eAA6c8+SlGpgYBCzErOZ/7d8g5J7pNm9OsX+Y0LNmfPqj6qDxo6
         312m/8FV69MXUuQNWqcT2DRaFhwEnrLk/gyV7FzLNwdn1Ds1Mm2Mp30F3FFVQIG2Wnpr
         GybnsYDaw/16+0slcnPW6SmFNoD66eTjshcnyEd7IfutfGL/qo66T9hvA/ub8O3/qZH3
         xNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=Yc/wWn41RLKXg/XnDWEYh5EY0Xa2lFOxeQbAbMbqZYE=;
        b=fCk8Wz2C7eOtI40iVSrAAW9ob6MY2EChZ+i8iSicJJEYwbsP6HP95JIGBCaT1W59bU
         yPAAHW4B3IEzIz5i5iBfG9bnb9Z9erIEHF8S5XMPNC22LIPUetnYz7djT/02+Bfpmu+T
         6soojUoJNnRUeuNtDkPhhfplIqC0TSnYDn0lxNTOZJ6g6DkTBe2+aiSEGewg0u96ebi7
         /n+ZttfZjJKfzyxLruyIWLQhysiMaFSCgBqD4M9fTywMOX3IbBtQztPqfLHsxhi7JSmw
         8G55oHxbhZ+vS7dzxwwt3LqKqHS/IviSRAQVO++K7cXGa8n/a+85EeW3dB6SSRTMOeSG
         F7BA==
X-Gm-Message-State: AOAM530nF2qWP85E1PvgTk0fqQMvxS0CTX9nVMCdIHGyiHwoi0/kOKZJ
        XUefE2nIcfQfyYBrtoNh4Qw=
X-Google-Smtp-Source: ABdhPJwgZCaM62cQhYnGhI4Q6cYrvzn4LhpwjTyTaV76k6roT6RgmeQUAp8ZTiwGLC8u1ncWDCT3iw==
X-Received: by 2002:a17:906:4fcb:b0:6e8:74db:6b04 with SMTP id i11-20020a1709064fcb00b006e874db6b04mr18370997ejw.676.1650458916931;
        Wed, 20 Apr 2022 05:48:36 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id p9-20020a05640243c900b0041facb9ac9esm196948edc.1.2022.04.20.05.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 05:48:36 -0700 (PDT)
Message-ID: <db1551628c191c8efdc2e7bec1313c58636c995e.camel@gmail.com>
Subject: Re: [PATCH v2 1/5] scsi: ufshpb: Merge ufshpb_reset() and
 ufshpb_reset_host()
From:   Bean Huo <huobean@gmail.com>
To:     keosung.park@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        cpgsproxy3 <cpgsproxy3@samsung.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 20 Apr 2022 14:48:35 +0200
In-Reply-To: <1891546521.01650433981606.JavaMail.epsvc@epcpadp4>
References: <20220419183044.789065-2-huobean@gmail.com>
         <20220419183044.789065-1-huobean@gmail.com>
         <CGME20220419183926epcas2p4f529c4cc6bed9ba4b6536f3a5977c3f2@epcms2p8>
         <1891546521.01650433981606.JavaMail.epsvc@epcpadp4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-20 at 11:47 +0900, Keoseong Park wrote:
> > +void ufshpb_toggle(struct ufs_hba *hba, enum UFSHPB_STATE src,
> > enum UFSHPB_STATE dest)
> How about changing it to something like ufshpb_state_toggle()?
>=20
> Best Regards,
> Keoseong Park

ufshpb_state_toggle() is much better, I will change it in the next
version. Thanks.

Kind regards,
Bean
