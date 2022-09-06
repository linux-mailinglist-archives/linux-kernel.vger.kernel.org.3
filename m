Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E595AE50F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiIFKLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiIFKLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:11:37 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD243845C;
        Tue,  6 Sep 2022 03:11:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so10893042pji.1;
        Tue, 06 Sep 2022 03:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=iwwaWYZrU4MnC67ORkK5zfgJ2Q9qlIgxiiXYGlPwwqg=;
        b=gneEe0ydyjv1KFHAggp+CMbuA0inNa2XgG1LLcUcnz4ETIg49v2igTE3XOx0oC9B37
         KI9lLakkajrr7WMLVTTnceXXDaw6fTp1t8yCw+zdT0EqZtUNQ3kCuRapUkxdjk6cBIuI
         61K6UKaXYM1Qm19pPzBsqOdn517ZocVYJkyn4B1wT35kGY3rEJUKrkFZK+ohI0XTQS1V
         FxujH0NUWCd6c6EsjaaU5OP53YxQG/8Py1ILA3LKOfFPMaR/xFfAkEtsZtpxhJ7zC4v9
         PQhUO4EUdQNs8ws6foAt2dN87KnYyzy5b0cPYOxHtC51cpj3h4Lp7cbYNgft+NMn79qG
         msCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=iwwaWYZrU4MnC67ORkK5zfgJ2Q9qlIgxiiXYGlPwwqg=;
        b=AHY5rZNb3VLIzZqZzWuz8HtI91S/1tvzVA1BZk2/f6wulBaPZXAu+xftCjBktGJYAm
         5LavpPRYifGZeUTBngKfvK9yNxIL4JGkDYUGxJKKiw83rvsv1lok2XLiQWNfpZKuJuCY
         xTEHXGRy39f/vXr1p8zmfDJlSr/2sTz6zO4LV7dDEFpqrGFSB9r1B+R5Znbd1kIqtwA+
         /FWFlwQH25eyakEKEDQcylvhNg35Oz0gu3oqC4EDqC5T65PR+PfHVknCvJx7r062sSok
         iTvj1jcitEL3Su2zPjXiAgJRtuHWuIX7W5SsqTsAASW2JvWJLQcKe67shQhYCUGldqXx
         ipig==
X-Gm-Message-State: ACgBeo2w1K8+c5wNa8mzXHy23IcF5raZopxitlH6YVKHl4U4fR5kRL7X
        qcHWGazorXn2ElnDSiLuQnU=
X-Google-Smtp-Source: AA6agR4bBOwTkPzCqEuChdVijgeEOS7ERN+2TjbgH/bPDFNqEvijFUjlmzKRoKd8W1SjG2vPe9svpg==
X-Received: by 2002:a17:90b:4a87:b0:1fd:f44a:1d9e with SMTP id lp7-20020a17090b4a8700b001fdf44a1d9emr23967857pjb.241.1662459095288;
        Tue, 06 Sep 2022 03:11:35 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090301ca00b0016c9e5f290esm9510965plh.10.2022.09.06.03.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 03:11:34 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: RE: [PATCH v9 6/6] thunderbolt: Add support for ASMedia image format
Date:   Tue,  6 Sep 2022 18:11:28 +0800
Message-Id: <20220906101128.6504-1-chensiying21@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Szuying Chen <Chloe_Chen@asmedia.com.tw>

Hi,

>  
> +static int asmedia_switch_nvm_version(struct tb_nvm *nvm) {
> +	struct tb_switch *sw = tb_to_switch(nvm->dev);
> +	u32 val;
> +	int ret;
> +
> +	ret = tb_switch_nvm_read(sw, ASMEDIA_NVM_VERSION, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	nvm->major = (val << 16) & 0xff0000;
> +	nvm->minor |= val & 0x00ff00;

	nvm->major

> +	nvm->major |= (val >> 16) & 0x0000ff;
> +
> +	ret = tb_switch_nvm_read(sw, ASMEDIA_NVM_DATE, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	nvm->minor = (val << 16) & 0xff0000;
> +	nvm->minor |= val & 0x00ff00;
> +	nvm->minor |= (val >> 16) & 0x0000ff;
> +
> +	/* ASMedia NVM size is fixed to 512k */
> +	nvm->active_size = SZ_512K;
> +
> +	return 0;
> +}
> +
> +static const struct tb_nvm_vendor_ops asmedia_switch_nvm_ops = {
> +	.read_version = asmedia_switch_nvm_version, };
> +
>  /* Router vendor NVM support table */
>  static const struct tb_nvm_vendor switch_nvm_vendors[] = {
> +	{ 0x174c, &asmedia_switch_nvm_ops },
>  	{ PCI_VENDOR_ID_INTEL, &intel_switch_nvm_ops },
>  	{ 0x8087, &intel_switch_nvm_ops },
>  };
> --

Thanks!

