Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5964AD795
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358845AbiBHLgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiBHLXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:23:06 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2AEC03FEC0;
        Tue,  8 Feb 2022 03:23:05 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m7so15894133pjk.0;
        Tue, 08 Feb 2022 03:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=yGdvePtA5J3T6k1Kw9exNjT0dNJZhtguuHy3n/iDjLY=;
        b=Hr8wTdnT0O/0KmLlu487Qb/smC8jLqUcQsEX+G/dEgowpk3OTwYmXeDqiUOJpYrqKO
         QY/XWRsLEwFCRIqQ0QabaOlDkfBiAK0dr3Dr8VOxX+l/iOiWzi6OngzUa8SrrdwSH02m
         IdF0zT5OuQbiB3Cic3wycyEzIi6jMlK1Lekth1+wi/TQp55IwHgucgjpKn2F04xedVC1
         inSUvte4ZyZjszTKJtllQL4VjLvAzuVLeJnzulIZdeznsr29VzrZ55nyXc5wTlR7JzL2
         XwBPQihX1k8gBTfbraXTFuz35qX5YIgJdxGwF6tnkmRLa+8Cifcl/8knjpJvdZXFcced
         SVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=yGdvePtA5J3T6k1Kw9exNjT0dNJZhtguuHy3n/iDjLY=;
        b=Wl8/C7WZMEicbmD4s45A2IA/f9o7z7wvO+rY5kPwElHnlDP54c91VUnIzStB3rVxtB
         RnAe56Bz7kaHymY8PXS6TOFJXQr1oxpKmggSpwSZzN647uUT+lxTTHTiwklkpn4WlEL8
         k4umEhVyT8pXbFado9Qy6eoLW+5TOPkA4J9u4F2bUCdZjaQhotsA32/f9Hg8teV4gv6I
         Q6h9ega0eing1uV1yGpU6XrNkQfFWt+ULigVpwNLuiMpWqU30xlLW0/Fd79gYcD7oi1c
         scD8bg9ccN/6lXb3wCQfuNVLGtyuyfXuFRzHHHyagJfYC+4LjI7agDjHjHCsKUgdLxHO
         cY0Q==
X-Gm-Message-State: AOAM5320Xl9KScxlmX/BJi1atNJzM2c4zhx8EfQ3HABsLyxAn72X+LTI
        BFeNQzFYRcrK0e/PTdVy2JbTcrUxlnY=
X-Google-Smtp-Source: ABdhPJxxkZQCGQ/F57OmjRz+c/13EOwyHYr+V5dIqqaQ0+VjrV3Y5rzJ8tsWGJ+tYNXh3eXzWO8HPQ==
X-Received: by 2002:a17:902:cec4:: with SMTP id d4mr3923507plg.158.1644319384555;
        Tue, 08 Feb 2022 03:23:04 -0800 (PST)
Received: from [192.168.1.100] ([166.111.139.99])
        by smtp.gmail.com with ESMTPSA id c7sm15437310pfp.164.2022.02.08.03.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 03:23:03 -0800 (PST)
To:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] scsi: qedi: possible ABBA deadlock in qedi_process_tmf_resp()
 and qedi_process_cmd_cleanup_resp()
Cc:     linux-scsi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <e468fdcb-f47f-e01a-da65-68da79020165@gmail.com>
Date:   Tue, 8 Feb 2022 19:23:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My static analysis tool reports a possible ABBA deadlock in the qedi 
driver in Linux 5.16:

qedi_process_tmf_resp()
   spin_lock(&session->back_lock); --> Line 201 (Lock A)
   spin_lock(&qedi_conn->tmf_work_lock); --> Line 230 (Lock B)

qedi_process_cmd_cleanup_resp()
   spin_lock_bh(&qedi_conn->tmf_work_lock); --> Line 752 (Lock B)
   spin_lock_bh(&conn->session->back_lock); --> Line 784 (Lock A)

When qedi_process_tmf_resp() and qedi_process_cmd_cleanup_resp() are 
concurrently executed, the deadlock can occur.

I am not quite sure whether this possible deadlock is real and how to 
fix it if it is real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
