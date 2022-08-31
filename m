Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F91F5A7DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiHaMvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiHaMvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:51:20 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08B9AB40F;
        Wed, 31 Aug 2022 05:51:16 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id f9so7286809qvw.11;
        Wed, 31 Aug 2022 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vANCqoOvWLAQ0AUaCxZw5ZDC4U8rvFiDAlZ8v8CmnPA=;
        b=FZlg+S1Jc25O5Qu02hlHQqZWpbWfZ+f4dHWTOmwzo6ntrKjC1rQri7/BY5ddVqbjlj
         99sLYecoF0b4/kD0lzNRDqiClNFqEhxT/QehY0Mgx6ClQpCXiSiniikrrErXkTjXwoWN
         dJfxYVxY5jAaIqk2pT4tIJ1HOAudWVEeZInPVAN9IuCyAe5wapEMb5LTPoBMH9Tj/bB9
         oPlizgkF5HmSPjO14JI3fDFIeKPKCvj8rIrly0xkmYyUNurGK8/hlaR5TlfUTBEbipFn
         yt1SmDqFBilinyEnmKYLlArqsXx5DmO6a2ZHfiu6mflxRhmrAip5O1Lh76SWGOPkVCcE
         PGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vANCqoOvWLAQ0AUaCxZw5ZDC4U8rvFiDAlZ8v8CmnPA=;
        b=0Rarcqlje7iqgvZulPDdx8rKDSbGpoA08sLXvBD73HXprFVKMnTsLWnUgJqkTGgM6B
         5sL/GZZisMaRovUHkR35ww50Uvq0Uw5SPYasfqm2xD0rD4ofRXIBaOBiqiza16q6Ngpt
         E1OikARH/fMK0W29bGYpPxrYkbIPH0lYV5av0CLMQmiVcrahD5Fy5lHIyeG1odDRUtjL
         FxaHl1cB5nGmmo/w0XFJ9FiT1A8m4w8wKCx8YXd2vUk2/WdJyCkpxQfJhuIfXbQrr0jy
         0iv7YLP/5f9NMVjwhIXkbY/K4Mycm3A0BAMMHaM2wMsPiBHxt/DWY/JJ75fNi7cHsOA8
         MnAA==
X-Gm-Message-State: ACgBeo3i8TPlgVRlJzr2qpABV+qWjsr1+KwsopGrH/gzpwahl5s6cvEN
        +VbJGRIhu6Tr4cphtbL4Dz4/TG4uWKyVQ4rjWW+LKwxT5J8=
X-Google-Smtp-Source: AA6agR79LvBSx1hiNMrygkbc9j/YvlYmDTHijaFQz088sM8dFiWdOZJGGJNNs1u70TVvb0kr6kSTMrlpwydX4bzFUgk=
X-Received: by 2002:ad4:5baf:0:b0:476:6a9e:b5e1 with SMTP id
 15-20020ad45baf000000b004766a9eb5e1mr19326591qvq.64.1661950275554; Wed, 31
 Aug 2022 05:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220831100506.3368103-1-vincent.whitchurch@axis.com> <20220831100506.3368103-5-vincent.whitchurch@axis.com>
In-Reply-To: <20220831100506.3368103-5-vincent.whitchurch@axis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Aug 2022 15:50:39 +0300
Message-ID: <CAHp75Vd=01XeLHmENOPCvv7AC6Sq-vre8fjLJKpkoJBKg+6+Xw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: adc: mcp320x: use device managed functions
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kernel <kernel@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 1:05 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Use devm_* functions in probe to remove some code and to make it easier
> to add further calls to the probe function.

devm_regulator_get_enable() ?

-- 
With Best Regards,
Andy Shevchenko
