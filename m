Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388114FE58B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353507AbiDLQKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiDLQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:10:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1915B52B00
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:08:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t25so10280326edt.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxIANWtTHyLaMzBOBDwW4uFwacwPEAMR+3BbQd3H0Yc=;
        b=Octrr/nWzS3t8PK5jXtNHYjE/qWyqvSpvbq6n9WwGfYF+XwATJ6FOCl0fzvobGleLK
         7goyC0U3JGOyrxDkw4030lxH22iSbbZmC+G4u9tXfci1dQObveOEamGS8MUQazeJzR0h
         4om2xUJHJRTj/8wwmHqYnYJd0e01jbcKDRIyu3TGfum84yzbMtrIlqo946uLUZeY/rre
         he1m51OO6fYSIo8zEnthuWgkCQ+hmSJT8bgd+Tpg8kaz4gzDXE74NNjor0Y+XiAcDRTF
         rypTt7fuC89jHMW+yFsSObgTAw43eU01v2OByaG1b984yLw+lRXGka4NpUF4pCY6JCYe
         iQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxIANWtTHyLaMzBOBDwW4uFwacwPEAMR+3BbQd3H0Yc=;
        b=GyDSBtovEqXNFBXlPQb/cU9Y13W8+P2zRgOwxb0qbq2yqIZxj0IdcbyJ3Bp8TC2+kY
         vEwGBk9BGNOu6OS6qHVYwonUkPdp59uHS6XF/SNX+NuQtXlGgBtEU5t5DYHsgqqwoHto
         QYZxxBOTgECy71h1p+Jy9ER0m6IoO470F5SCqArDKT2u3ucjTh6Lp3mLpfwn2BmnGlct
         rpMZnJqcMxP1FzoV/llZLmKn/NO3LdwvtJNJiDmxvIiwxKmJZAJnVMEvkfBS0ERgHQxG
         BZWETYQgERrioU7CGRRIXH+pKydN53Rypma2+pbvyWsbbfsZ6mGzEgGK8YQ7Zzq+D7Al
         l9bw==
X-Gm-Message-State: AOAM531V2vlRclsWXHxZzm5DxcnRNLq1my7zQSsQR1VdSE3Pi3lGYKrr
        bReQPPVKpJYtgtDs9jjIDbQ=
X-Google-Smtp-Source: ABdhPJyZ/T7Rgd0BXte+iXG4x5G2LGDskFXuelLSrHY9jGVD1N8SEmHlvpoyn3STAtTNvtVPwnOYaA==
X-Received: by 2002:aa7:cad3:0:b0:410:b188:a49a with SMTP id l19-20020aa7cad3000000b00410b188a49amr39244738edt.416.1649779707514;
        Tue, 12 Apr 2022 09:08:27 -0700 (PDT)
Received: from leap.localnet (host-82-60-208-254.retail.telecomitalia.it. [82.60.208.254])
        by smtp.gmail.com with ESMTPSA id p24-20020a1709061b5800b006e88dfea127sm2938296ejg.3.2022.04.12.09.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 09:08:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v2 0/7] drop some unnecessary wrappers
Date:   Tue, 12 Apr 2022 18:08:24 +0200
Message-ID: <3134226.AJdgDx1Vlc@leap>
In-Reply-To: <20220412151529.GF3293@kadam>
References: <20220411102136.14937-1-makvihas@gmail.com> <3484215.R56niFO833@leap> <20220412151529.GF3293@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted? 12 aprile 2022 17:15:29 CEST Dan Carpenter wrote:
> On Tue, Apr 12, 2022 at 11:53:42AM +0200, Fabio M. De Francesco wrote:
> > I didn't suggest a re-write of the commit messages.
> 
> Yes.  That's the problem.  If you want to complain about a commit
> message then you *should* suggest how you would re-write it.  Otherwise
> how are we supposed to read your mind?

Ah, sorry. I had missed that you were asking for a re-write (literally).

Here it is a sort of diff on Vihas' patch:

- [PATCH v2 1/7] staging: r8188eu: drop unnecessary wrapper _rtw_free_cmd_priv
+ [PATCH v2 1/7] staging: r8188eu: drop unnecessary helper _rtw_free_cmd_priv()

- Drop unnecessary wrapper _rtw_free_cmd_priv and move its logic to
- rtw_free_cmd_priv.
+ Drop unnecessary helper (wrapped function) _rtw_free_cmd_priv() and
+ move its code to the wrapper rtw_free_cmd_priv().

> > I just pointed out that those messages are formally inaccurate but
> > that these kinds of small formal inaccuracies
> 
> I'm so puzzled but what you mean here.  There were no "small formal
> inaccuracies".  The patch removed unnecessary wrappers exactly as
> described.  

The patch removed unnecessary helpers.

> Anyway, I haven't seen your proposed commit message so I
> can't say.
> 
> regards,
> dan carpenter

Thanks,

Fabio M. De Francesco 




