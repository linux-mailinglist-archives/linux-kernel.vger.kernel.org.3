Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2975AEE8A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiIFPVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiIFPVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:21:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B94979F7;
        Tue,  6 Sep 2022 07:33:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t7so10737973wrm.10;
        Tue, 06 Sep 2022 07:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=CacYXd80H/4iKUtP95NJ2HU11T1upV6JWfF7yq6PmMI=;
        b=aBWi3NdcEgEfbb+sbSbJsDEhXSSi/Uc0bU5gUbGUqwm9DvOrujbfJl6FtG2sByYOnX
         9mndiYwLC5LYSobUzh0rdwoe2FRZSWFl3Vb+B5ySe4ckI4k93NFQIYNDWmY3/2mLnkl+
         yVa/ZL0P4yS6SqI+vET+0v1tyrJWtVhk7F24JVgbjvXDIqsuAmZaI+z0dHqqxsYUwINZ
         zOiVrY8YQP4bS13G9Y6KuLAZjEvVufRKbFemwGT4JdoPaASZW+ibFUutv1Gx1OUpOTZC
         JbRTSO0iwPtEvHYmMLBI6aAe4jFloe6UZvDvQcJ7VDpLM3TURBW3x3wG1bzF2oSy535t
         lBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CacYXd80H/4iKUtP95NJ2HU11T1upV6JWfF7yq6PmMI=;
        b=6BWYF5W/osqiopwsL9aKPXeBgXhOyQGuZvaasnIeUxaJPPrXm+KX6IbPcN2DdbTx32
         RIQ8nV69utSpPZgaUDjmDucP5AEZCRGRcVXh0wT8r3Bpyqpo3g5gUorWB02c8k6/ES4z
         E0pdLOoc3nTQBx9yzLF1bv/OOG/UTYOFEsushZWo8uWhE1QuJnWhhXFBAURepvDmWt8u
         +xe9/2S0MjkcXvEr3qngn7vDGDD6muNWFIOCGcBsQFNnyGfFnM4pxF1k54s/4e/hvaAO
         wxFQRHIVhPgGfnol+bjC8Z+BFbN1/dsgDSLLhGdm8kn9scy39eQuMjUVuJ9xPWxm+JeI
         7Mow==
X-Gm-Message-State: ACgBeo1XahLD/wom4HmRfiECCwEgdmPCTmCyY/Wb0EjLu/MsU3ffy4Cz
        1EE4nZurED5B9lIvNqPV750=
X-Google-Smtp-Source: AA6agR6BR0GaenA77FNVG6e4NdISUtIGSsIuV4W47D+6BjCDGMjbEyR0LsAa8UX8fzSaB7HPKealRQ==
X-Received: by 2002:a5d:4805:0:b0:228:db70:6641 with SMTP id l5-20020a5d4805000000b00228db706641mr1684859wrq.377.1662474753900;
        Tue, 06 Sep 2022 07:32:33 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6d42000000b00226f0a00348sm12738493wri.111.2022.09.06.07.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 07:32:33 -0700 (PDT)
Date:   Tue, 6 Sep 2022 15:32:31 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Arun Easi <aeasi@marvell.com>, Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: build failure of next-20220906 due to 8bfc149ba24c ("scsi: qla2xxx:
 Enhance driver tracing with separate tunable and more")
Message-ID: <YxdZ/9XOsWilvVSd@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The builds of loongarch loongson3_defconfig have failed to build
next-20220906 with the error:

drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_init':
drivers/scsi/qla2xxx/qla_os.c:2854:25: error: implicit declaration of function 'trace_array_get_by_name'; did you mean 'trace_array_set_clr_event'? [-Werror=implicit-function-declaration]
 2854 |         qla_trc_array = trace_array_get_by_name("qla2xxx");
      |                         ^~~~~~~~~~~~~~~~~~~~~~~
      |                         trace_array_set_clr_event

drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_uninit':
drivers/scsi/qla2xxx/qla_os.c:2869:9: error: implicit declaration of function 'trace_array_put' [-Werror=implicit-function-declaration]
 2869 |         trace_array_put(qla_trc_array);
      |         ^~~~~~~~~~~~~~~


git bisect pointed to 8bfc149ba24c ("scsi: qla2xxx: Enhance driver tracing with separate tunable and more").

I will be happy to test any patch or provide any extra log if needed.


--
Regards
Sudip
