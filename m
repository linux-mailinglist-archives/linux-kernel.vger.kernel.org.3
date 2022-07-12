Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B255717F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiGLLEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiGLLEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:04:49 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD98AF751
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:04:46 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31c8bb90d09so76952737b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+mkI/2QTZ74hBU3I5vk4XNmJY229tPWuPrbAxP17BU=;
        b=H5P5TpYGgrS+PCqVigdhPTeYP+WKe5gqoL3dckXZrMOhsddHRBNk2nLwSGXs09BlnZ
         FZ2RwY4phX9IdTGwRSprjOWll2UXx05GLS2fZqmHf4AQ7Uyp9xsBkWYeKagYQpj6JAD0
         hGI0Lix/akLZHkfKTOLqfW2YsbP+miOEj0ZfNbd0kyXdE9al6iaQL3NZZ5/5GnhWlDIe
         4Ae7UnGE1Jz/9SLkpEDAPOOte36VTQztORRC+qYaldL6QFRPgxviTsT3BL561/cPlkbS
         NqCf1iOPxL393YOFaeLK7WhMRaWudnevhYfMGlOYc+j1ZY1Kg8WYFNn7lnM7GRpUMoUB
         r29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+mkI/2QTZ74hBU3I5vk4XNmJY229tPWuPrbAxP17BU=;
        b=o/bQEztnp7uAinlZpHzmsc8trWuCkEHE3l0YkSRKDdeYyLqsgyqGKWzA6jKFo/NAEQ
         p1+itEEmSUw95chNlKYSnx4oXsB7BrVRc08iVtf+GhzrdpUZ+0uGBZ/GFqYheLriECSz
         T+ts3NIUAVzcwgZ2CtZy3dcCpFOLVxigJA3pcp4Oxi0AQSQl/M0pqtHlBHutsh4ix3+V
         04piYNZ+kNnjOvxaC+UMTuCf8dDzueIScNx8angVJJjkVgvgyoYh/XWnpzq6/NtKdHw7
         rH6oEEeF8nd2JGyrJN1U/OI7LxiH4OB0EBthUGk2hG8EcKkb0slMdsh9yBEdJgJ1o3vD
         Ghuw==
X-Gm-Message-State: AJIora9bHsLAKBqda4PrFlq1qvog5gYjH9T4WxdCIzg6jiNQvMmOFRTN
        7t1pDbZt+zc6uyRzq6UDujWC4DvS/6G9uGpVa6zoDg==
X-Google-Smtp-Source: AGRyM1uw66tVXfDg0JvZIuFiaHVG3pA7FPi/F5wTW7DmBlcGCy2rwJfB0C6dTkRvSM6lRdjAQ1wiGlEylsjqDGl4ruM=
X-Received: by 2002:a81:112:0:b0:317:8cc9:ccde with SMTP id
 18-20020a810112000000b003178cc9ccdemr24504998ywb.273.1657623885748; Tue, 12
 Jul 2022 04:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220701145815.2037993-4-bhupesh.sharma@linaro.org> <202207081955.SXcfKpLo-lkp@intel.com>
In-Reply-To: <202207081955.SXcfKpLo-lkp@intel.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 12 Jul 2022 16:34:32 +0530
Message-ID: <CAH=2NtyNYUh9pcX8zb2hP7Qcs8_drRhg1YuHG9PK=zb9K8NdOQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal: qcom: tsens: Implement re-initialization
 workaround quirk
To:     kernel test robot <lkp@intel.com>
Cc:     linux-pm@vger.kernel.org, kbuild-all@lists.01.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Jul 2022 at 17:10, kernel test robot <lkp@intel.com> wrote:
>
> Hi Bhupesh,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on rafael-pm/thermal]
> [also build test ERROR on linus/master v5.19-rc5 next-20220707]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh-Sharma/Add-support-for-tsens-controller-reinit-via-trustzone/20220701-230113
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
> config: arm64-randconfig-r015-20220707 (https://download.01.org/0day-ci/archive/20220708/202207081955.SXcfKpLo-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/32929e13eb338e76b714bb8b4805899e2857734f
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Bhupesh-Sharma/Add-support-for-tsens-controller-reinit-via-trustzone/20220701-230113
>         git checkout 32929e13eb338e76b714bb8b4805899e2857734f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    aarch64-linux-ld: Unexpected GOT/PLT entries detected!
>    aarch64-linux-ld: Unexpected run-time procedure linkages detected!
>    aarch64-linux-ld: ID map text too big or misaligned
>    aarch64-linux-ld: drivers/thermal/qcom/tsens.o: in function `tsens_probe':
> >> drivers/thermal/qcom/tsens.c:1337: undefined reference to `qcom_scm_is_available'
>    aarch64-linux-ld: drivers/thermal/qcom/tsens.o: in function `get_temp_tsens_valid':
> >> drivers/thermal/qcom/tsens.c:714: undefined reference to `qcom_scm_tsens_reinit'
>
>
> vim +1337 drivers/thermal/qcom/tsens.c
>
>   1293
>   1294  static int tsens_probe(struct platform_device *pdev)
>   1295  {
>   1296          int ret, i;
>   1297          struct device *dev;
>   1298          struct device_node *np;
>   1299          struct tsens_priv *priv;
>   1300          const struct tsens_plat_data *data;
>   1301          const struct of_device_id *id;
>   1302          u32 num_sensors;
>   1303
>   1304          if (pdev->dev.of_node)
>   1305                  dev = &pdev->dev;
>   1306          else
>   1307                  dev = pdev->dev.parent;
>   1308
>   1309          np = dev->of_node;
>   1310
>   1311          id = of_match_node(tsens_table, np);
>   1312          if (id)
>   1313                  data = id->data;
>   1314          else
>   1315                  data = &data_8960;
>   1316
>   1317          num_sensors = data->num_sensors;
>   1318
>   1319          if (np)
>   1320                  of_property_read_u32(np, "#qcom,sensors", &num_sensors);
>   1321
>   1322          if (num_sensors <= 0) {
>   1323                  dev_err(dev, "%s: invalid number of sensors\n", __func__);
>   1324                  return -EINVAL;
>   1325          }
>   1326
>   1327          priv = devm_kzalloc(dev,
>   1328                               struct_size(priv, sensor, num_sensors),
>   1329                               GFP_KERNEL);
>   1330          if (!priv)
>   1331                  return -ENOMEM;
>   1332
>   1333          priv->dev = dev;
>   1334          priv->num_sensors = num_sensors;
>   1335          priv->needs_reinit_wa = data->needs_reinit_wa;
>   1336
> > 1337          if (priv->needs_reinit_wa && !qcom_scm_is_available())
>   1338                  return -EPROBE_DEFER;
>   1339
>   1340          if (priv->needs_reinit_wa) {
>   1341                  priv->reinit_wa_worker = alloc_workqueue("tsens_reinit_work",
>   1342                                                           WQ_HIGHPRI, 0);
>   1343                  if (!priv->reinit_wa_worker)
>   1344                          return -ENOMEM;
>   1345
>   1346                  INIT_WORK(&priv->reinit_wa_notify, tsens_reinit_worker_notify);
>   1347          }
>   1348
>   1349          priv->ops = data->ops;
>   1350          for (i = 0;  i < priv->num_sensors; i++) {
>   1351                  if (data->hw_ids)
>   1352                          priv->sensor[i].hw_id = data->hw_ids[i];
>   1353                  else
>   1354                          priv->sensor[i].hw_id = i;
>   1355          }
>   1356          priv->feat = data->feat;
>   1357          priv->fields = data->fields;
>   1358
>   1359          platform_set_drvdata(pdev, priv);
>   1360
>   1361          if (!priv->ops || !priv->ops->init || !priv->ops->get_temp) {
>   1362                  ret = -EINVAL;
>   1363                  goto free_wq;
>   1364          }
>   1365
>   1366          ret = priv->ops->init(priv);
>   1367          if (ret < 0) {
>   1368                  dev_err(dev, "%s: init failed\n", __func__);
>   1369                  goto free_wq;
>   1370          }
>   1371
>   1372          if (priv->ops->calibrate) {
>   1373                  ret = priv->ops->calibrate(priv);
>   1374                  if (ret < 0) {
>   1375                          if (ret != -EPROBE_DEFER)
>   1376                                  dev_err(dev, "%s: calibration failed\n", __func__);
>   1377
>   1378                          goto free_wq;
>   1379                  }
>   1380          }
>   1381
>   1382          ret = tsens_register(priv);
>   1383          if (ret < 0) {
>   1384                  dev_err(dev, "%s: registration failed\n", __func__);
>   1385                  goto free_wq;
>   1386          }
>   1387
>   1388          list_add_tail(&priv->list, &tsens_device_list);
>   1389          return 0;
>   1390
>   1391  free_wq:
>   1392          destroy_workqueue(priv->reinit_wa_worker);
>   1393          return ret;
>   1394  }
>   1395

Thanks, I will fix this in v2.

Regards,
Bhupesh
